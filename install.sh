#!/usr/bin/env bash

set -e

install_fonts() {
  # Nerd Fonts
  # https://github.com/ryanoasis/nerd-fonts
  if ! (fc-list | grep -q FiraCode)
  then
    artifact="FiraCode.zip"
    version="v2.3.3"
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$artifact
    unzip -o $artifact -d $HOME/.fonts
    rm $artifact
    fc-cache -fv
  fi
}

install_vim() {
  # https://github.com/junegunn/vim-plug
  if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]
  then
    curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
  fi

  if [ ! -x "$(command -v nvim)" ]
  then
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update && sudo apt install neovim
  fi
}

# https://www.rust-lang.org/tools/install
install_rust() {
  if [ ! -x "$(command -v rustup)" ]
  then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
  fi
}

# https://github.com/BurntSushi/ripgrep grep so fast
# https://github.com/jdxcode/rtx asdf in rust
# https://starship.rs fancy prompt
# https://github.com/dbrgn/tealdeer fast tldr
# https://github.com/zellij-org/zellij terminal multiplexer
install_cargo_packages() {
  packages="ripgrep rtx-cli starship tealdeer zellij"
  cargo install --locked $packages
  tldr --update
}

install_alacritty_terminfo() {
  if ! infocmp alacritty > /dev/null; then
    curl \
      --fail \
      --location \
      --output /tmp/alacritty.info \
      https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info

    sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info
  fi
}

# command-line fuzzy finder https://github.com/junegunn/fzf
install_fzf() {
  if [ ! -d "${HOME}/.fzf" ]
  then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    $HOME/.fzf/install
  fi
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
  packages="alacritty build-essential cmake curl fd-find file git jq libssl-dev stow tig tree uidmap unzip vim xclip"
  sudo apt update && sudo apt install --assume-yes $packages
  stow alacritty bash git nvim vim
  install_fonts
  install_vim
  install_rust
  install_cargo_packages
  install_alacritty_terminfo
  install_fzf
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
