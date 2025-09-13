#!/bin/bash
SCRIPT_DIRNAME=$(dirname "$0")
PROJECT_DIR=$(cd "${SCRIPT_DIRNAME}/.." || exit 1;pwd)

# bin, lib フォルダがなければ作成
if [ ! -e "${PROJECT_DIR}/bin" ]; then mkdir -p "${PROJECT_DIR}/bin"; fi
if [ ! -e "${PROJECT_DIR}/lib" ]; then mkdir -p "${PROJECT_DIR}/lib"; fi

# 必要なライブラリを確認し、なければダウンロード
if [ ! -e "${PROJECT_DIR}/lib/junit-4.13.2.jar" ]; then
  curl -L -O https://repo1.maven.org/maven2/junit/junit/4.13.2/junit-4.13.2.jar
  mv junit-4.13.2.jar "${PROJECT_DIR}/lib/junit-4.13.2.jar"
fi
if [ ! -e "${PROJECT_DIR}/lib/hamcrest-core-1.3.jar" ]; then
  curl -L -O https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar
  mv hamcrest-core-1.3.jar "${PROJECT_DIR}/lib/hamcrest-core-1.3.jar"
fi

# JAR 用クラスパス
CP_JAR="${PROJECT_DIR}/lib/slf4j-api-2.0.17.jar"
CP_JAR="${PROJECT_DIR}/lib/slf4j-simple-2.0.17.jar:${CP_JAR}"
CP_JAR="${PROJECT_DIR}/lib/junit-4.13.2.jar:${CP_JAR}"
CP_JAR="${PROJECT_DIR}/lib/hamcrest-core-1.3.jar:${CP_JAR}"

# コンパイル
CP="${CP_JAR}:${PROJECT_DIR}/bin:${PROJECT_DIR}/src"
javac -d "${PROJECT_DIR}/bin" -cp "${CP}" "${PROJECT_DIR}/src/AppTest.java"

# テスト実行
CP="${CP_JAR}:${PROJECT_DIR}/bin"
java -cp "${CP}" org.junit.runner.JUnitCore AppTest
