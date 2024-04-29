#!/bin/sh
APP_DIR_NAME=app001
BASE_DIR=$(cd $(dirname $0)/../../..;pwd)
SRC_DIR=${BASE_DIR}/share
DC_PROJ_NAME=devcon-python-fastapi-prisma
DC_SERVICE_NAME=devcon-python-fastapi-prisma

## - アーカイブファイルのコピー
docker compose -p ${DC_PROJ_NAME} \
    cp ${SRC_DIR}/${APP_DIR_NAME}.tgz \
        ${DC_SERVICE_NAME}:/workspace/

## - リポジトリの展開
docker compose -p ${DC_PROJ_NAME} \
    exec --workdir /workspace ${DC_SERVICE_NAME} \
        tar xvzf ${APP_DIR_NAME}.tgz -C /workspace --wildcards "${APP_DIR_NAME}/.git/*"

## - アーカイブファイルの削除
docker compose -p ${DC_PROJ_NAME} \
    exec ${DC_SERVICE_NAME} \
        rm -fr /workspace/${APP_DIR_NAME}.tgz
