#!/bin/sh
PROJ_NAME=devcon-python-fastapi-prisma
APP_DIR_NAME=app001
BASE_DIR=$(cd $(dirname $0);pwd)
SRC_DIR=$(cd ${BASE_DIR}/../../dev/${PROJ_NAME};pwd)
RESOURCE_DIR=${BASE_DIR}/resource

DC_FILE_PATH="${BASE_DIR}/compose.yaml"
DC_PROJ_NAME=${PROJ_NAME}
DC_SERVICE_NAME=${PROJ_NAME}

# アプリ用のファイル（イメージ作成用）をコピー。
APP_SRC_PATH=${SRC_DIR}/${APP_DIR_NAME}

# アプリ用のファイルがない場合は処理を終了
if [ ! -e "${APP_SRC_PATH}" ]; then
    echo "not found: ${APP_SRC_PATH}"
    exit 1
fi

# コピー
cp -r "${APP_SRC_PATH}" "${BASE_DIR}/${APP_DIR_NAME}"

# .env ファイルの用意
APP_ENV_FILE_PATH=${RESOURCE_DIR}/.env
if [ ! -e "${APP_ENV_FILE_PATH}" ]; then
    # .env ファイルがない場合はエラー
    echo "not found: ${APP_ENV_FILE_PATH}"
    exit 1
fi
cp ${APP_ENV_FILE_PATH} "${BASE_DIR}/${APP_DIR_NAME}/"

# ビルド
docker compose -f "${DC_FILE_PATH}" build
# キャッシュを使わないビルド（下記を有効にする場合は上記をコメントにすること）
# docker compose -f "${DC_FILE_PATH}" build --no-cache

# アプリ用のファイル（イメージ作成用）を削除
rm -fr ${BASE_DIR}/${APP_DIR_NAME}