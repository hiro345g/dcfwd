#!/bin/sh

# 現在の Python 仮想環境があるなら、それを削除
current_venv=$(poetry env list | awk '{print $1}')
if [ "x${current_venv}" != "x" ]; then
    poetry env remove ${current_venv}
fi

# プロジェクト直下に Python 仮想環境を作成
poetry config virtualenvs.in-project true
poetry install --no-root
