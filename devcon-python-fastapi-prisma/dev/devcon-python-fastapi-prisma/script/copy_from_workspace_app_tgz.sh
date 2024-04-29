#!/bin/sh
PROJ_NAME=devcon-python-fastapi-prisma
APP_DIR_NAME=app001
BASE_DIR=$(cd $(dirname $0)/../../..;pwd)
DEST_DIR="${BASE_DIR}/share"
DC_PROJ_NAME=${PROJ_NAME}
DC_SERVICE_NAME=${PROJ_NAME}

# コンテナー内でアーカイブ
docker compose -p ${DC_PROJ_NAME} \
    exec --workdir=/workspace ${DC_SERVICE_NAME} \
        tar cvzf ${APP_DIR_NAME}.tgz ${APP_DIR_NAME}

# コンテナーからコピー
docker compose -p ${DC_PROJ_NAME} \
    cp ${DC_SERVICE_NAME}:/workspace/${APP_DIR_NAME}.tgz ${DEST_DIR}/

# コンテナー内のアーカイブ削除
docker compose -p ${DC_PROJ_NAME} \
    exec --workdir=/workspace ${DC_SERVICE_NAME} \
        rm /workspace/${APP_DIR_NAME}.tgz