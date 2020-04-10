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

# rbenv https://github.com/rbenv/rbenv
if [ ! -d "${HOME}/.rbenv" ]
then
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  $HOME/.rbenv/bin/rbenv init

  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
fi

# nvm (install or update) https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# https://github.com/nvengal/tools
if [ ! -d "${HOME}/tools" ]
then
  git clone git@github.com:nvengal/tools $HOME/tools

  pushd $HOME/tools
  ./setup.sh
  popd
fi
