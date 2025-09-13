#!/bin/bash
SCRIPT_DIRNAME=$(dirname "$0")
PROJECT_DIR=$(cd "${SCRIPT_DIRNAME}/.." || exit 1;pwd)

# bin, lib フォルダがなければ作成
if [ ! -e "${PROJECT_DIR}/bin" ]; then mkdir -p "${PROJECT_DIR}/bin"; fi
if [ ! -e "${PROJECT_DIR}/lib" ]; then mkdir -p "${PROJECT_DIR}/lib"; fi

# 必要なライブラリを確認し、なければダウンロード
if [ ! -e "${PROJECT_DIR}/lib/slf4j-api-2.0.17.jar" ]; then
  curl -L -O https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.17/slf4j-api-2.0.17.jar
  mv slf4j-api-2.0.17.jar "${PROJECT_DIR}/lib/slf4j-api-2.0.17.jar"
fi
if [ ! -e "${PROJECT_DIR}/lib/slf4j-simple-2.0.17.jar" ]; then
  curl -L -O https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/2.0.17/slf4j-simple-2.0.17.jar
  mv slf4j-simple-2.0.17.jar "${PROJECT_DIR}/lib/slf4j-simple-2.0.17.jar"
fi

# コンパイル
CP="${PROJECT_DIR}/src"
CP="${PROJECT_DIR}/lib/slf4j-api-2.0.17.jar:${CP}"
CP="${PROJECT_DIR}/lib/slf4j-simple-2.0.17.jar:${CP}"
javac -d "${PROJECT_DIR}/bin" -cp "${CP}" "${PROJECT_DIR}/src/App.java"

echo "Build successful!"
