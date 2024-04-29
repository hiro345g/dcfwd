#! /bin/sh

cd /workspace \
  && curl -LO https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz \
  && tar xf starship-x86_64-unknown-linux-musl.tar.gz \
  && rm starship-x86_64-unknown-linux-musl.tar.gz
echo 'eval "$(/workspace/starship init bash)"' >> /root/.bashrc
if [ ! -e /root/.config ]; then mkdir /root/.config; fi
/workspace/starship preset plain-text-symbols > /root/.config/starship.toml
sed -i 's/Rocky = "rky "//' /root/.config/starship.toml
