#! /bin/sh
SCRIPT_DIR=$(dirname "$0")
BUILD_DEVCON_DIR=$(cd "${SCRIPT_DIR}" || exit 1;pwd)

cd "${BUILD_DEVCON_DIR}" || exit 1
if [ "${NO_CACHE}" = "ENABLE" ]; then
    docker compose run --rm -it --env NO_CACHE=ENABLE dvc-nestjs-build-image
else
    docker compose run --rm -it dvc-nestjs-build-image
fi

docker compose down

