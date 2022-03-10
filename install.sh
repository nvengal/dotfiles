#!/usr/bin/env zsh

set -e

# vim-plug https://github.com/junegunn/vim-plug
ln -is ${PWD}/vimrc ${HOME}/.vimrc
if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]
then
  curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# zpresto https://github.com/sorin-ionescu/prezto
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]
then
  setopt EXTENDED_GLOB

  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  mv "${ZDOTDIR:-$HOME}"/.zprezto/runcoms "${ZDOTDIR:-$HOME}"/.zprezto/runcoms.orig

  ln -s ${PWD}/zprezto "${ZDOTDIR:-$HOME}"/.zprezto/runcoms

  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -is "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
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

# https://github.com/nvengal/tools
if [ ! -d "${HOME}/tools" ]
then
  git clone git@github.com:nvengal/tools $HOME/tools

  if [ -n "$(command -v docker)" ]
  then
    pushd $HOME/tools
    bash ./setup.sh
    popd
  else
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "  WARNING nvengal/tools installation requires docker"
    echo "  Install docker and run $HOME/tools/setup.sh"
  fi
fi

# Powerline Fonts
# https://github.com/powerline/fonts
git clone https://github.com/powerline/fonts.git --depth=1
pushd fonts && ./install.sh
popd && rm -rf fonts
