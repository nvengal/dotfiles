#!/usr/bin/env bash

set -e

sudo apt update

# Colorscheme
#   https://github.com/Mayccoll/Gogh
sudo apt install dconf-cli uuid-runtime
bash -c "$(curl -sLo- https://git.io/vQgMr)"

# TMUX
#   https://github.com/tmux/tmux
sudo apt install tmux -y

# Powerline Hack Font (used by Starship)
#   https://github.com/source-foundry/Hack
sudo apt install fonts-hack-ttf -y

# Starship Prompt
#   https://starship.rs/
[ -n "$(command -v starship)" ] \
  || curl -fsSL https://starship.rs/install.sh | bash

echo "SUCCESS"
