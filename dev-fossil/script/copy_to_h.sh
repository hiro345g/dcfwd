#!/bin/sh
# Docker ホストへコピー
d=$(cd $(dirname $0)/../devcontainer-script;pwd)
docker compose -p dev-fossil cp ubuntu2004:/root/install-fossil.sh ${d}/
docker compose -p dev-fossil cp ubuntu2004:/root/install-node.sh ${d}/
docker compose -p dev-fossil cp ubuntu2004:/root/init-angular.sh ${d}/
docker compose -p dev-fossil cp ubuntu2004:/root/useradd-node.sh ${d}/
