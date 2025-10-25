#! /bin/sh
IMAGE_NAME=dvc-mise:base
SCRIPT_DIR=$(dirname "$0")
BUILD_DEVCON_DIR=$(cd "${SCRIPT_DIR}" || exit 1;pwd)
PATH=${PATH}:${NPM_CONFIG_PREFIX}/bin

cd "${BUILD_DEVCON_DIR}" || exit 1
# shellcheck disable=SC2086,SC2068
npm exec --package=@devcontainers/cli -- \
    devcontainer build \
        --workspace-folder .\
        --config ./devcontainer.json \
        --image-name ${IMAGE_NAME} $@
