#!/bin/sh

for v in dvc-mise-share-mise dvc-mise-state-mise; do
  if docker volume ls | grep "${v}" > /dev/null; then
    docker volume rm "${v}"
  fi
done
