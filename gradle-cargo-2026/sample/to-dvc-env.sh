#!/bin/sh
BASE_DIRNAME=$(dirname "$0")
BASE_DIR=$(cd "${BASE_DIRNAME}/.." || exit 1; pwd)

SAMPLE_DIR="${BASE_DIR}/sample"
BACKUP_DIR="${SAMPLE_DIR}/backup"
APP_DIR="${BASE_DIR}/webapp001"

if [ ! -e "${BACKUP_DIR}" ]; then
    mkdir -p "${BACKUP_DIR}"
fi
if [ ! -e "${APP_DIR}/.settings}" ]; then
    mkdir -p "${APP_DIR}/.settings"
fi

for f in .classpath .project; do
    if [ -e "${APP_DIR}/${f}" ]; then
        if [ ! -e "${BACKUP_DIR}/dot${f}" ]; then
            # バックアップがある場合は上書きしない。ない場合は移動。
            mv "${APP_DIR}/${f}" "${BACKUP_DIR}/dot${f}"
        fi
    fi
    cp "${SAMPLE_DIR}/dot${f}" "${APP_DIR}/${f}"
done

list=$(cat << EOS
org.eclipse.jdt.core.prefs
org.eclipse.wst.common.component
org.eclipse.wst.common.project.facet.core.xml
EOS
)

for f in ${list}; do
    if [ -e "${APP_DIR}/.settings/${f}" ]; then
        if [ ! -e "${BACKUP_DIR}/settings.${f}" ]; then
            # バックアップがある場合は上書きしない。ない場合は移動。
            mv "${APP_DIR}/.settings/${f}" "${BACKUP_DIR}/settings.${f}"
        fi
    fi
    cp "${SAMPLE_DIR}/settings.${f}" "${APP_DIR}/.settings/${f}"
done
