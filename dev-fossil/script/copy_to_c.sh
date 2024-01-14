#!/bin/sh
d=$(cd $(dirname $0)/../devcontainer-script;pwd)
docker compose -p dev-fossil cp ${d}/install-fossil.sh ubuntu2004:/root/
