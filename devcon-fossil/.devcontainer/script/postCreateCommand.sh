#!/bin/sh

apt update \
    && apt -y upgrade \
    && apt -y install fossil sqlite3 \
    && chown node:node /home/node/repo \
    && sudo -u node /usr/bin/sh /script/postCreateCommand-node.sh