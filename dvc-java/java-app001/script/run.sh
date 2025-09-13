#!/bin/bash
SCRIPT_DIRNAME=$(dirname "$0")
PROJECT_DIR=$(cd "${SCRIPT_DIRNAME}/.." || exit 1;pwd)

# ビルド時とテスト実行時に必要な準備はしてあるため、ここでは実行するのみ
CP="${PROJECT_DIR}/bin"
for f in "${PROJECT_DIR}/lib"/*; do
  CP="$f:${CP}"
done
java -cp "${CP}" App
