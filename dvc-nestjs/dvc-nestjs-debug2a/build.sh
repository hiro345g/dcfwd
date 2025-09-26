#! /bin/sh
#
# このスクリプトを実行すると `compose.yaml` で指定済みの `dvc-nestjs:debug2a-base` イメージを `dvc-nestjs:debug2a` と同じイメージに上書きする点に注意
#
IMAGE_NAME=dvc-nestjs:debug2a
SCRIPT_DIR=$(dirname "$0")
BUILD_DEVCON_DIR=$(cd "${SCRIPT_DIR}" || exit 1;pwd)
PATH=${PATH}:${NPM_CONFIG_PREFIX}/bin

OPT_NO_CACHE=""
if [ "${NO_CACHE}" = "ENABLE" ]; then
    OPT_NO_CACHE="--no-cache"
fi

cd "${BUILD_DEVCON_DIR}" || exit 1
npm exec --yes --package=@devcontainers/cli -- \
    devcontainer build \
        ${OPT_NO_CACHE} \
        --workspace-folder .\
        --config ./.devcontainer/devcontainer.json \
        --image-name ${IMAGE_NAME}

if [ "${USER_NAME}" = "" ]; then
    exit 0
fi
docker tag ${IMAGE_NAME} "${USER_NAME}/${IMAGE_NAME}"
