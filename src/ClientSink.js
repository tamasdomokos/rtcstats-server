
const logger = require('./logging');
const storeFile = require('./store/file');

const messageTypes = {
    SequenceNumber: 'sn'
};

/**
 * This handles sending the messages to the frontend
 */
class ClientSink {
    /**
     * @param tempPath {string}
     * @param sequenceNumberSendingInterval {number}
     */
    constructor({ id, tempPath, sequenceNumberSendingInterval, demuxSink, client }) {
        this.id = id;
        this.tempPath = tempPath;
        this.sequenceNumberSendingInterval = sequenceNumberSendingInterval;
        this.demuxSink = demuxSink;
        this.client = client;
    }

    /**
     *  Sends the last sequence number from demuxSink or reads from the dump file
    */
    sendLastSequenceNumber() {

        let sequenceNumber = 0;

        if (this.demuxSink.lastSequenceNumber > 0) {
            sequenceNumber = this.demuxSink.lastSequenceNumber;
        } else {
            sequenceNumber = this._getLastSequenceNumberFromDump();
        }

        this.client.send(
            JSON.stringify(
                this._createMessage(messageTypes.SequenceNumber, sequenceNumber)
            )
        );
        setTimeout(() => this.sendLastSequenceNumber(this.client, this.id), this.sequenceNumberSendingInterval);
    }

    /**
     * Reads the last sequnce number from the dump file.
     */
    _getLastSequenceNumberFromDump() {
        const dumpPath = `${this.tempPath}/${this.id}`;

        storeFile.getLastLine(dumpPath, 1)
            .then(
                lastLine => {
                    const jsonData = JSON.parse(lastLine);

                    if (Array.isArray(jsonData) && jsonData[4] !== undefined) {
                        return jsonData[4];
                    }
                })
            .catch(() => {
                logger.info('[App] New connection. File doesn\'t exist.');
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

module.exports = ClientSink;
