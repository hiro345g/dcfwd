#!/bin/sh

df=$(cd $(dirname $0)/..;pwd)/docker-compose.yml

docker compose -f ${df} down

n=fossil_default
docker network ls --filter "name=${n}" | grep ${n}
if [ $? -eq 0 ]; then
    echo -n "[info] network remove ${n}: "
    docker compose -f ${df} down
else
    echo "[info] network ${n} already removed."
fi

v=dev-fossil-ubuntu2204-root-dir-data
docker volume ls --filter "name=${v}" | grep ${v}
if [ $? -eq 0 ]; then
    echo -n "[info] volume remove ${v}: "
    docker volume remove ${v}
else
    echo "[info] volume ${v} already removed."
fi
