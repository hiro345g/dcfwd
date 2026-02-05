FROM hiro345g/dvc:ruby-202602

# rvm を最新版へ変更、インストールされている 3.4.8 は使えなくなるのでアンインストール
RUN export GNUPGHOME="/tmp/tmp-gnupg" \
    && mkdir -p "$GNUPGHOME" \
    && chmod 700 "$GNUPGHOME" \
    && curl -sSL https://rvm.io/mpapis.asc | gpg --batch --import - \
    && curl -sSL https://rvm.io/pkuczynski.asc | gpg --batch --import - \
    && /usr/local/rvm/bin/rvm remove 3.4.8 || true \
    && /usr/local/rvm/bin/rvm get head \
    && /usr/local/rvm/bin/rvm reload \
    && /usr/local/rvm/bin/rvm all do rvm repair all \
    && rm -rf "$GNUPGHOME"

# rvm を最新版に変更してから、3.4.8、4.0.0 の順にインストール後、デフォルトを 4.0.0 に設定
RUN /usr/local/rvm/bin/rvm install 3.4.8 \
    && /usr/local/rvm/bin/rvm install 4.0.0 \
    && /usr/local/rvm/bin/rvm alias create default 4.0.0

# gem のシステムアップデートと bundler のアップデート
RUN /usr/local/rvm/bin/rvm all do gem update --system \
    && /usr/local/rvm/bin/rvm all do gem install bundler \
    && chown -R node:rvm /usr/local/rvm
