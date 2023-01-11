const JSONStream = require('JSONStream');
const { pipeline } = require('stream');
const url = require('url');
const WebSocket = require('ws');

const ClientMessageHandler = require('./ClientMessageHandler');
const DemuxSink = require('./demux');
const logger = require('./logging');
const PromCollector = require('./metrics/PromCollector');
const { getStatsFormat } = require('./utils/stats-detection');
const { extractTenantDataFromUrl } = require('./utils/utils');

/**
 *
 */
class WsHandler {

    /**
     *
     */
    constructor({ tempPath, reconnectTimeout, sequenceNumberSendingInterval, dumpPersister }) {
        this.sessionIdTimeouts = {};
        this.tempPath = tempPath;
        this.reconnectTimeout = reconnectTimeout;
        this.sequenceNumberSendingInterval = sequenceNumberSendingInterval;
        this.dumpPersister = dumpPersister;
    }

    /**
     *
     * @param {*} wsServer
     */
    setupWebSocketsServer(wsServer) {
        const wss = new WebSocket.Server({ server: wsServer });

        wss.on('connection', this._handle.bind(this));

        return wss;
    }

    /**
     * Main handler for web socket connections.
     * Messages are sent through a node stream which saves them to a dump file.
     * After the websocket is closed the session is considered as terminated and the associated dump
     * is queued up for feature extraction through the {@code WorkerPool} implementation.
     *
     * @param {*} client
     * @param {*} upgradeReq
     */
    _handle(client, upgradeReq) {
        PromCollector.connected.inc();

        // the url the client is coming from
        const referer = upgradeReq.headers.origin + upgradeReq.url;
        const ua = upgradeReq.headers['user-agent'];
        const queryObject = url.parse(referer, true).query;
        const statsSessionId = queryObject?.statsSessionId;

        const connectionInfo = this._createConnectionInfo(upgradeReq, referer, ua, client);
        const demuxSink = this._createDemuxSink(connectionInfo);

        logger.info('[WsHandler] Client connected: %s', statsSessionId);
        const clientMessageHandler = this._createClientMessageHandler(statsSessionId, demuxSink, client);

        this._clearConnectionTimeout(statsSessionId);
        clientMessageHandler.sendLastSequenceNumber(true);

        demuxSink.on('close-sink', ({ id, meta }) => {

            logger.info(
                '[WsHandler] Websocket disconnected waiting for processing the data %s in %d ms',
                id,
                this.reconnectTimeout
            );

            const { confID = '' } = meta;
            const tenantInfo = extractTenantDataFromUrl(confID);

            const timemoutId = setTimeout(
                () => this.dumpPersister.processData(id, meta, connectionInfo, tenantInfo), this.reconnectTimeout
            );

            this.sessionIdTimeouts[id] = timemoutId;
        });

        const connectionPipeline = pipeline(
            WebSocket.createWebSocketStream(client),
            JSONStream.parse(),
            demuxSink,
            err => {
                if (err) {
                    // A pipeline can multiplex multiple sessions however if one fails
                    // the whole pipeline does as well,
                    PromCollector.sessionErrorCount.inc();

                    logger.error('[WsHandler] Connection pipeline: %o;  error: %o', connectionInfo, err);
                }
            });

        connectionPipeline.on('finish', () => {
            logger.info('[WsHandler] Connection pipeline successfully finished %o', connectionInfo);

            // We need to explicity close the ws, you might notice that we don't do the same in case of an error
            // that's because in that case the error will propagate up the pipeline chain and the ws stream will also
            // close the ws.
            client.close();
        });

        logger.info(
            '[WsHandler] New app connected: ua: %s, protocol: %s, referer: %s',
            ua,
            client.protocol,
            referer
        );

        client.on('error', e => {
            logger.error('[WsHandler] Websocket error: %s', e);
            PromCollector.connectionError.inc();
        });

        client.on('close', () => {
            PromCollector.connected.dec();
        });
    }

    /**
     *
     */
    _createDemuxSink(connectionInfo) {
        const demuxSinkOptions = {
            tempPath: this.tempPath,
            connectionInfo,
            dumpFolder: './temp',
            log: logger
        };

        return new DemuxSink(demuxSinkOptions);
    }

    /**
     *
     */
    _createClientMessageHandler(statsSessionId, demuxSink, client) {
        const clientMessageHandlerOptions = {
            statsSessionId,
            tempPath: this.tempPath,
            sequenceNumberSendingInterval: this.sequenceNumberSendingInterval,
            demuxSink,
            client
        };

        return new ClientMessageHandler(clientMessageHandlerOptions);
    }

    /**
     *
     * @returns
     */
    _createConnectionInfo(upgradeReq, referer, ua, client) {
        // During feature extraction we need information about the browser in order to decide which algorithms use.
        const connectionInfo = {
            path: upgradeReq.url,
            origin: upgradeReq.headers.origin,
            url: referer,
            userAgent: ua,
            clientProtocol: client.protocol
        };

        connectionInfo.statsFormat = getStatsFormat(connectionInfo);

        return connectionInfo;
    }

    /**
     * Clear the connection timeout if the user is reconnected/
     *
     * @param {*} id
     */
    _clearConnectionTimeout(id) {
        const timeoutId = this.sessionIdTimeouts[id];

        if (timeoutId) {
            logger.info('[WsHandler] Clear timeout for connectionId: %s', id);
            clearTimeout(timeoutId);
        }
    }
}

module.exports = WsHandler;
