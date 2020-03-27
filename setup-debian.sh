#!/usr/bin/env bash

set -e

sudo apt update

# Powerline Hack Font (used by Starship)
#   https://github.com/source-foundry/Hack
sudo apt install fonts-hack-ttf

# Starship Prompt
#   https://starship.rs/
curl -fsSL https://starship.rs/install.sh | bash
