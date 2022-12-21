
const logger = require('./logging');
const storeFile = require('./store/file');
const utils = require('./utils/utils');

const messageTypes = {
    SequenceNumber: 'sn'
};

/**
 * This handles sending the messages to the frontend
 */
class ClientMessageHandler {
    /**
     * @param tempPath {string}
     * @param sequenceNumberSendingInterval {number}
     */
    constructor({ statsSessionId, tempPath, sequenceNumberSendingInterval, demuxSink, client }) {
        logger.debug('[ClientMessageHandler] Constructor statsSessionId', statsSessionId);
        this.statsSessionId = statsSessionId;
        this.tempPath = tempPath;
        this.sequenceNumberSendingInterval = sequenceNumberSendingInterval;
        this.demuxSink = demuxSink;
        this.client = client;
    }

    /**
     *  Sends the last sequence number from demuxSink or reads from the dump file
    */
    sendLastSequenceNumber() {
        logger.debug('[ClientMessageHandler] Sending last sequence number for: ', this.statsSessionId);
        let sequenceNumber = 0;

        if (this.demuxSink.lastSequenceNumber > 0) {
            logger.debug('[ClientMessageHandler] Last sequence number from demux ');
            sequenceNumber = this.demuxSink.lastSequenceNumber;
        } else {
            logger.debug('[ClientMessageHandler] Last sequence number from dump ');
            sequenceNumber = this._getLastSequenceNumberFromDump();
        }

        this.client.send(
            JSON.stringify(
                this._createMessage(messageTypes.SequenceNumber, sequenceNumber)
            )
        );

        if (this.client.readyState === 1) {
            setTimeout(() => this.sendLastSequenceNumber(this.client, this.statsSessionId),
                this.sequenceNumberSendingInterval);
        }
        logger.debug('[ClientMessageHandler] Last sequence number: ', sequenceNumber);
    }

    /**
     * Reads the last sequnce number from the dump file.
     */
    _getLastSequenceNumberFromDump() {
        const dumpPath = `${this.tempPath}/${this.statsSessionId}`;

        logger.debug('[ClientMessageHandler] Last sequence number from dump: ', dumpPath);

        storeFile.getLastLine(dumpPath, 1)
            .then(
                lastLine => utils.parseLineForSequenceNumber(lastLine))
            .catch(() => {
                logger.debug('[ClientMessageHandler] New connection. File doesn\'t exist. file: ', dumpPath);

                return -1;
            });
    }

    /**
     *
     * @param type {string}
     * @param body {string}
     * @returns {{body, type}}
     */
    _createMessage(type, body) {
        return {
            'type': type,
            'body': body
        };
    }
}

module.exports = ClientMessageHandler;