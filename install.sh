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
  # Powerline Fonts
  # https://github.com/powerline/fonts
  git clone https://github.com/powerline/fonts.git --depth=1
  pushd fonts && ./install.sh
  popd && rm -rf fonts
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
install_cargo_packages() {
  packages="rtx-cli starship"
  cargo install $packages --locked
}

install_linux() {
  packages="alacritty build-essential cmake curl file git libssl-dev stow xclip"
  sudo apt update && sudo apt install --assume-yes $packages
  stow bash git vim
  setup_vim
  install_fonts
  install_rust
  install_cargo_packages
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
