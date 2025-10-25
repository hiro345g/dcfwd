#!/bin/sh
SCRIPT_DIR=$(dirname "$0")
PROJECT_DIR=$(cd "${SCRIPT_DIR}/.." || exit 1;pwd)

if [ ! -e "${PROJECT_DIR}/.gemini" ]; then
  if [ -e ~/.gemini ]; then
    cp -a ~/.gemini "${PROJECT_DIR}/"
  else
    mkdir "${PROJECT_DIR}/.gemini"
  fi
fi
