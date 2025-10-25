#! /bin/sh
SCRIPT_DIR=$(dirname "$0")
BUILD_DIR=$(cd "${SCRIPT_DIR}" || exit 1;pwd)

if docker image ls | grep dvc-mise-base > /dev/null; then
  if [ ! -e "${BUILD_DIR}/build-base-image/build.sh" ]; then
    echo "build dvc-mise-base image"
    exit 1
  fi
  bash "${BUILD_DIR}/build-base-image/build.sh"
fi

# shellcheck disable=SC2068
docker compose -f "${BUILD_DIR}/compose.yaml" build $@
