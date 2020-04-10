#!/usr/bin/env bash

set -e

sudo apt update

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
