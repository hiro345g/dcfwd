#!/bin/sh
BASE_DIRNAME=$(dirname "$0")
BASE_DIR=$(cd "${BASE_DIRNAME}/.." || exit 1; pwd)

SAMPLE_DIR="${BASE_DIR}/sample"
BACKUP_DIR="${SAMPLE_DIR}/backup"
APP_DIR="${BASE_DIR}/webapp001"

for f in .classpath .project; do
    if [ -e "${BACKUP_DIR}/dot${f}" ]; then
        mv "${BACKUP_DIR}/dot${f}" "${APP_DIR}/${f}"
    fi
done

list=$(cat << EOS
org.eclipse.jdt.core.prefs
org.eclipse.wst.common.component
org.eclipse.wst.common.project.facet.core.xml
EOS
)

for f in ${list}; do
    if [ -e "${APP_DIR}/.settings/${f}" ]; then
        mv "${BACKUP_DIR}/settings.${f}" "${APP_DIR}/.settings/${f}"
    fi
done
