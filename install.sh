#!/bin/zsh

# vim-plug https://github.com/junegunn/vim-plug
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]
then
  ln -is ${PWD}/vimrc ${HOME}/.vimrc
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
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
