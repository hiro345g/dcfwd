#!/bin/sh
# shellcheck disable=SC2016,SC2088

curl https://mise.run | sh

cat << EOS >> ~/.bashrc
if [[ "\$TERM_PROGRAM" == "vscode" ]]; then
  eval "\$(~/.local/bin/mise activate bash --shims)"
else
  eval "\$(~/.local/bin/mise activate bash)"
fi
EOS

echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
cat << EOS >> ~/.zprofile
if [[ "\$TERM_PROGRAM" == "vscode" ]]; then
  eval "\$(~/.local/bin/mise activate zsh --shims)"
elif; then
  eval "\$(~/.local/bin/mise activate zsh)"
fi
EOS

# echo '~/.local/bin/mise activate fish | source' >> ~/.config/fish/config.fish

# bash -c 'mise -y use -g node@system'
# bash -c 'mise -y install node@23.11.1'
