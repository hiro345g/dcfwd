FROM dvc-mise:base

COPY ./mise.toml /home/vscode/.config/mise/config.toml
COPY ./script/install-mise.sh /usr/local/bin/install-mise.sh
COPY ./script/update-mise.sh /usr/local/bin/update-mise.sh

RUN chown -R vscode:vscode /home/vscode/.config/mise
RUN sudo -u vscode sh -c 'sh /usr/local/bin/install-mise.sh' \
  && mkdir -p /home/vscode/.local/share/mise \
  && chown -R vscode:vscode /home/vscode/.local/share \
  && sudo -u vscode sh -c 'bash /usr/local/bin/update-mise.sh'

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get -y install \
      build-essential autoconf \
      libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y locate \
      autoconf bison build-essential \
      curl gettext git libgd-dev libcurl4-openssl-dev libedit-dev \
      libicu-dev libjpeg-dev libmariadb-dev-compat libmariadb-dev libonig-dev \
      libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev \
      libzip-dev openssl pkg-config re2c zlib1g-dev \
  && apt-get -y autoremove \
  && apt-get -y clean \
  && rm -rf /var/cache/apt /var/lib/apt/lists \
  && /usr/bin/updatedb

USER vscode

# vscode ユーザーで mise インストール
# Ruby と PHP については、処理が重くなるので一時的に除外
RUN sed -i 's/php =/#php =/' /home/vscode/.config/mise/config.toml
RUN sed -i 's/ruby =/#ruby =/' /home/vscode/.config/mise/config.toml
RUN bash -c '\
  eval "$(~/.local/bin/mise activate bash)"; \
  mise install -y --jobs 2; \
'

# gemini-cli を vscode ユーザーでグローバルインストール
RUN bash -c '\
  eval "$(~/.local/bin/mise activate bash)"; \
  npm install -g @google/gemini-cli; \
  mkdir /home/vscode/.gemini; \
'

# locate 用 DB のアップデート
RUN sudo /usr/bin/updatedb

# 作業用に workspace/dvc-mise の用意
RUN sudo mkdir -p /workspaces/dvc-mise && sudo chown -R vscode:vscode /workspaces/dvc-mise
WORKDIR /workspaces/dvc-mise

# Ruby
RUN sed -i 's/#ruby =/ruby =/' /home/vscode/.config/mise/config.toml
RUN bash -c '\
  eval "$(~/.local/bin/mise activate bash)"; \
  mise install -y; \
'

# PHP
RUN sed -i 's/#php =/php =/' /home/vscode/.config/mise/config.toml
RUN bash -c '\
  eval "$(~/.local/bin/mise activate bash)"; \
  mise install -y; \
'

# mise trust WORKDIR and set auto_install=false
RUN bash -c '\
  eval "$(~/.local/bin/mise activate bash)"; \
  mise trust; \
  mise settings auto_install=false; \
'

# - Ruby: <https://mise.jdx.dev/lang/ruby.html>
# - PHP : <https://github.com/asdf-community/asdf-php>
#   - <https://github.com/asdf-community/asdf-php/blob/master/.github/workflows/workflow.yml>
#   - sed 's/libmysqlclient-dev /libmariadb-dev-compat libmariadb-dev /'
