#!/bin/sh
PROJ_NAME=devcon-python-fastapi-prisma
APP_DIR_NAME=app001
BASE_DIR=$(cd $(dirname $0)/..;pwd)
DEST_DIR="${BASE_DIR}/${APP_DIR_NAME}"
DC_PROJ_NAME=${PROJ_NAME}
DC_SERVICE_NAME=${PROJ_NAME}

# コンテナーから Git リポジトリー経由でファイルコピー
## - 既存のものは削除
if [ -e ${DEST_DIR} ]; then
    rm -fr ${DEST_DIR}
fi

## - リポジトリ用ワーキングディレクトリの用意。
mkdir ${DEST_DIR}

## - リポジトリのコピー
docker compose -p ${DC_PROJ_NAME} \
    cp ${DC_SERVICE_NAME}:/workspace/${APP_DIR_NAME}/.git \
        ${DEST_DIR}/.git

## - リポジトリから HEAD をチェックアウト
git -C ${DEST_DIR} checkout -- .

## - リポジトリの削除
rm -fr ${DEST_DIR}/.git
