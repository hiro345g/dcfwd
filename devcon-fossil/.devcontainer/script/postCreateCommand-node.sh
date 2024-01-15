#!/bin/sh
REPO_FILE=/home/node/repo/proj001.fossil

if [ -e ${HOME}/.local/share/vscode-sqltools/ ]; then
  cd ${HOME}/.local/share/vscode-sqltools/
  npm install sqlite3@5.1.1
fi
if [ ! -e ${REPO_FILE} ]; then
  fossil new ${REPO_FILE}
fi
