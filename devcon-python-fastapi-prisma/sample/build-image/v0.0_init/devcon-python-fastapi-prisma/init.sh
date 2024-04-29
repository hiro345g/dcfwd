#!/bin/sh
PROJ_NAME=devcon-python-fastapi-prisma
BASE_DIR=$(cd $(dirname $0);pwd)
DEST_DIR=$(cd ${BASE_DIR}/../../dev/${PROJ_NAME};pwd)

DC_BUILD_FILE_PATH=${BASE_DIR}/compose.yaml
DC_FILE_PATH=${DEST_DIR}/compose.yaml
DC_PROJ_NAME=${PROJ_NAME}
DC_SERVICE_NAME=${PROJ_NAME}

# devcon-python-fastapi-prisma イメージの削除
docker image ls | grep ${DC_PROJ_NAME} | grep "0.1"
if [ $? -eq 0 ]; then
    echo "docker image rm devcon-python-fastapi-prisma:0.1"
    docker image rm devcon-python-fastapi-prisma:0.1
fi
# devcon-python-fastapi-prisma-workspace-data ボリュームの削除
docker volume ls | grep devcon-python-fastapi-prisma-workspace-data
if [ $? -eq 0 ]; then
    echo "docker volume rm devcon-python-fastapi-prisma-workspace-data"
    docker volume rm devcon-python-fastapi-prisma-workspace-data
fi

# 使用する Docker イメージのビルド
docker compose -f "${DC_BUILD_FILE_PATH}" build

# 開発プロジェクト用ファイルの作成
## - devcon-python-fastapi-prisma:/workspace/app001/pyproject.toml の作成
docker compose -f ${DC_FILE_PATH} run --rm \
    --workdir /workspace/app001 --entrypoint "\
    /root/.local/bin/poetry init \
        --no-interaction \
        --name app001 \
        --dependency fastapi \
        --dependency uvicorn[standard] \
    " ${DC_SERVICE_NAME}

## - devcon-python-fastapi-prisma:/workspace/app001/poetry.lock の作成
docker compose -f ${DC_FILE_PATH} run --rm \
    --workdir /workspace/app001 --entrypoint "\
    /root/.local/bin/poetry install --no-root\
    " ${DC_SERVICE_NAME}

# app001 をホストへコピー
## - コンテナー起動
docker compose -f ${DC_FILE_PATH} up -d

## - 起動チェック
until \
    docker compose ls -a --filter name=${DC_PROJ_NAME} \
    | grep "${DC_PROJ_NAME}" \
    | grep "running"
do
    >&2 echo "${DC_PROJ_NAME} is not available - sleeping"
    sleep 1
done

## - app001 コピー
docker compose -p ${DC_PROJ_NAME} \
    cp ${DC_SERVICE_NAME}:/workspace/app001 ${DEST_DIR}/    

## - 停止
docker compose -p ${DC_PROJ_NAME} down
