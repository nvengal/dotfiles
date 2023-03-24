#!/usr/bin/env bash

set -e

# vim-plug https://github.com/junegunn/vim-plug
ln -is ${PWD}/vimrc ${HOME}/.vimrc
if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]
then
  curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# tmux
ln -is ${PWD}/tmux.conf ${HOME}/.tmux.conf

# asdf version manager https://github.com/asdf-vm/asdf
if [ ! -d "${HOME}/.asdf" ]
then
  git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf
  pushd $HOME/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  popd

  ln -is ${PWD}/asdfrc ${HOME}/.asdfrc

  ./install-asdf-plugins.sh
fi

# Powerline Fonts
# https://github.com/powerline/fonts
git clone https://github.com/powerline/fonts.git --depth=1
pushd fonts && ./install.sh
popd && rm -rf fonts

install_linux() {
  packages="build-essential curl file git libssl-dev xclip"
  sudo apt update && sudo apt install --assume-yes $packages
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

  stow
}

main
