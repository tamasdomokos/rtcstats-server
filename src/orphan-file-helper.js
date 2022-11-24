const fs = require('fs');

const logger = require('./logging');
const fileStore = require('./store/file');

/**
 *
 */
class OrphanFileHelper {
    /**
     *
     */
    constructor({ tempPath, reconnectTimeout, dumpPersister }) {
        this.tempPath = tempPath;
        this.reconnectTimeout = reconnectTimeout;
        this.dumpPersister = dumpPersister;
    }

    /**
     * Remove old files from the temp folder.
     */
    processOldFiles() {
        logger.info('[OrphanFileHelper] Waiting for connections to reconnect.');
        try {
            if (fs.existsSync(this.tempPath)) {
                fs.readdirSync(this.tempPath).forEach(fname => {
                    try {
                        const filePath = `${this.tempPath}/${fname}`;

                        logger.debug(`[OrphanFileHelper] Trying to process file ${filePath}`);
                        fs.stat(filePath, (err, stats) => {
                            if (err) {
                                throw err;
                            }

                            this.processIfExpired(stats, filePath, fname);
                        });
                    } catch (e) {
                        logger.error(`[OrphanFileHelper] Error while unlinking file ${fname} - ${e}`);
                    }
                });
            } else {
                logger.error('[OrphanFileHelper] Temp path doesn\'t exists. path: ', this.tempPath);
            }
        } catch (e) {
            logger.error(`[OrphanFileHelper] Error while accessing working dir ${this.tempPath} - ${e}`);

            // The app is probably in an inconsistent state at this point, throw and stop process.
            throw e;
        }
    }

    /**
     *
     */
    processIfExpired(stats, filePath, fname) {
        const lastModifiedDurationMs = Math.abs(Date.now() - stats.mtime.getTime());

        logger.debug(`[OrphanFileHelper] File last modified ${lastModifiedDurationMs} ms ago:`);
        if (lastModifiedDurationMs > this.reconnectTimeout) {
            logger.debug(`[OrphanFileHelper] Start processing the file ${`${filePath}`}`);
            const response = fileStore.getObjectsByKeys(
                filePath, [ 'connectionInfo', 'identity' ]);

            response.then(
                obj => {
                    const meta = obj?.connectionInfo;
                    const connectionInfo = obj?.identity;

                    setTimeout(
                        () => this.dumpPersister.processData(fname, meta, connectionInfo),
                        this.reconnectTimout);
                })
                .catch(() => {
                    logger.info(`[OrphanFileHelper] New connection. File doesn't exist. ${filePath}`);
                });
        }
    }
}

module.exports = OrphanFileHelper;
