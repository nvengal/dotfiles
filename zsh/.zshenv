# zshenv

HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

if command -v nvim > /dev/null; then
  export {EDITOR,GIT_EDITOR}=nvim
else
  export {EDITOR,GIT_EDITOR}=vim
fi

# https://docs.commonfate.io/granted-cli/shell-alias/
alias assume='source assume'

. "$HOME/.cargo/env"
