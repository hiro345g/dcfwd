#!/bin/bash
SCRIPT_DIRNAME=$(dirname "$0")
PROJECT_DIR=$(cd "${SCRIPT_DIRNAME}/.." || exit 1;pwd)

# ビルド時とテスト実行時に必要な準備はしてあるため、ここでは実行するのみ
CP="${PROJECT_DIR}/bin"
CP="${PROJECT_DIR}/lib/slf4j-api-2.0.17.jar:${CP}"
CP="${PROJECT_DIR}/lib/slf4j-simple-2.0.17.jar:${CP}"
java -cp "${CP}" App
