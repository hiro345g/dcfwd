#!/bin/sh
d=$(cd $(dirname $0)/../devcontainer-script;pwd)
docker compose -p dev-fossil cp ubuntu2004:/root/install-fossil.sh ${d}/
