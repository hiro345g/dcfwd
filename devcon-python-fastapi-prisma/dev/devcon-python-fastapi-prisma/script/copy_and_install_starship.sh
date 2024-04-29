#!/bin/sh
SCRIPT_NAME=install_starship.sh
BASE_DIR=$(cd $(dirname $0)/../../..;pwd)
SRC_DIR=${BASE_DIR}/sample/build-image/v0.3/devcon-python-fastapi-prisma
SRC_FILE_PATH=${SRC_DIR}/${SCRIPT_NAME}
DC_PROJ_NAME=devcon-python-fastapi-prisma
DC_SERVICE_NAME=devcon-python-fastapi-prisma

## - ファイルのコピー
docker compose -p ${DC_PROJ_NAME} \
    cp ${SRC_FILE_PATH} ${DC_SERVICE_NAME}:/

## - インストール
docker compose -p ${DC_PROJ_NAME} \
    exec ${DC_SERVICE_NAME} sh /${SCRIPT_NAME}