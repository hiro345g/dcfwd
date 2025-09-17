
FROM hiro345g/dvc:jdk-202507

# パッケージインストールのため root
USER root

# Linux で Gemini CLI を使う場合で、認証時に xdg-utils が必要と
# なることがあるため、インストールしておく。
RUN apt-get update \
    && apt-get install -y xdg-utils \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/cache/apt /var/lib/apt/lists

# ここから node ユーザーによる作業
USER node

# gemini-cli を node ユーザーでグローバルインストール
RUN npm install -g @google/gemini-cli
