#! /bin/sh
SCRIPT_DIR=$(dirname "$0")
BUILD_DIR=$(cd "${SCRIPT_DIR}" || exit 1;pwd)
BASE_BUILD_DIR=$(cd "${SCRIPT_DIR}"/../build-base-image || exit 1;pwd)

if docker image ls --format "{{.Repository}}:{{.Tag}}" | grep "dvc-mise:base" > /dev/null; then
  :
else
  if [ ! -e "${BASE_BUILD_DIR}/build.sh" ]; then
    echo "Please build dvc-mise:base image"
    exit 1
  fi
  echo "---- building dvc-mise:base image"
  bash "${BASE_BUILD_DIR}/build.sh"
fi

# shellcheck disable=SC2068
docker compose -f "${BUILD_DIR}/compose.yaml" build $@
