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

# # asdf version manager https://github.com/asdf-vm/asdf
# install_asdf() {
#   if [ ! -d "${HOME}/.asdf" ]
#   then
#     git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf
#     pushd $HOME/.asdf
#     git checkout "$(git describe --abbrev=0 --tags)"
#     popd

#     install_asdf_plugins
#   fi
# }

# install_asdf_plugins() {
#   readonly STARSHIP_VERSION=1.4.1

#   echo "Installing starship ${STARSHIP_VERSION}"
#   asdf plugin add starship && \
#     asdf install starship $STARSHIP_VERSION && \
#     asdf global starship $STARSHIP_VERSION
# }

install_linux() {
  packages="build-essential curl file git libssl-dev stow xclip"
  sudo apt update && sudo apt install --assume-yes $packages
  stow bash git vim
  setup_vim
  install_fonts
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
