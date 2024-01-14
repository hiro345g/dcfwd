#!/bin/sh
# dev-fossil 開発コンテナーへコピー
d=$(cd $(dirname $0)/../devcontainer-script;pwd)
docker compose -p dev-fossil cp ${d}/install-fossil.sh ubuntu2004:/root/
docker compose -p dev-fossil cp ${d}/install-node.sh ubuntu2004:/root/
docker compose -p dev-fossil cp ${d}/init-angular.sh ubuntu2004:/root/
docker compose -p dev-fossil cp ${d}/useradd-node.sh ubuntu2004:/root/
