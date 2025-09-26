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

# SDKMAN! のインストール先を指定
ENV  SDKMAN_DIR=/usr/local/sdkman

# gemini-cli を node ユーザーでグローバルインストール
RUN npm install -g @google/gemini-cli

# sdk コマンドを使えるように設定
RUN bash -c 'echo "[[ -s \"/usr/local/sdkman/bin/sdkman-init.sh\" ]] && source \"/usr/local/sdkman/bin/sdkman-init.sh\"" >> /home/node/.bashrc'

# SDKMAN! による spring コマンドのインストール
RUN bash -c 'source /usr/local/sdkman/bin/sdkman-init.sh && sdk install springboot 3.5.6'

# Gradle, Maven 用ユーザーフォルダの用意
RUN bash -c 'mkdir /home/node/.m2 && mkdir /home/node/.gradle'
