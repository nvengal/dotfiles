#!/usr/bin/env bash

set -e

setup_vim() {
  # vim-plug https://github.com/junegunn/vim-plug
  if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]
  then
    curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
  fi
}

install_fonts() {
  # Nerd Fonts
  # https://github.com/ryanoasis/nerd-fonts
  artifact="FiraCode.zip"
  version="v2.3.3"
  curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$artifact
  unzip -o $artifact -d $HOME/.fonts
  rm $artifact
  fc-cache -fv
}

## tmux
#ln -is ${PWD}/tmux.conf ${HOME}/.tmux.conf

# https://www.rust-lang.org/tools/install
install_rust() {
  if [ ! -x "$(command -v rustup)" ]
  then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
  fi
}

# https://github.com/jdxcode/rtx asdf in rust
# https://starship.rs fancy prompt
# https://github.com/dbrgn/tealdeer fast tldr
install_cargo_packages() {
  packages="ripgrep rtx-cli starship tealdeer zellij"
  cargo install --locked $packages
  tldr --update
}

# https://docs.docker.com/engine/install/debian/
install_docker() {
  if [ ! -x "$(command -v docker)" ]
  then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh ./get-docker.sh
    dockerd-rootless-setuptool.sh install
    sudo apt install --assume-yes docker-compose
    rm get-docker.sh
  fi
}

install_linux() {
  packages="alacritty build-essential cmake curl file git libssl-dev stow tree uidmap unzip vim xclip"
  sudo apt update && sudo apt install --assume-yes $packages
  stow alacritty bash git vim
  setup_vim
  install_fonts
  install_rust
  install_cargo_packages
  install_docker
}

main() {
  os=$(uname | tr '[:upper:]' '[:lower:]')
  case $os in
    linux)
      install_$os
      ;;
    *)
      echo $os not supported
      exit 1
      ;;
  esac
}

main
