#!/usr/bin/env zsh

set -e

sudo apt update

# Colorscheme
#   https://github.com/Mayccoll/Gogh
sudo apt install dconf-cli uuid-runtime
bash -c "$(curl -sLo- https://git.io/vQgMr)"

# xclip
#   Enables copy/paste to system clipboard from terminal
sudo apt install xclip -y

# TMUX
#   https://github.com/tmux/tmux
sudo apt install tmux -y

# ripgrep
#   https://github.com/BurntSushi/ripgrep
sudo apt install ripgrep

# Powerline Hack Font (used by Starship)
#   https://github.com/source-foundry/Hack
sudo apt install fonts-hack-ttf -y

# Docker mysql conf
#   Unclear why this step is necessary
#   Without it mysql in docker is not allowed to create a lock file
#   In theory mysql will run with user id 999 in the container
#     https://github.com/docker-library/mysql/blob/d284e15821ac64b6eda1b146775bf4b6f4844077/8.0/Dockerfile#L3
mysql_conf_file="/usr/lib/tmpfiles.d/mysqld.conf"
mysql_conf_command="d /var/run/mysqld 0755 999 999 -"
if [ ! -f $mysql_conf_file ]; then
    echo $mysql_conf_command | sudo tee $mysql_conf_file
fi

echo "SUCCESS"
