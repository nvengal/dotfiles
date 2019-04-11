#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export VISUAL=vim
export EDITOR="$VISUAL"

export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost
alias start-pg='pg_ctl -l $PGDATA/server.log start'
alias stop-pg='pg_ctl stop -m fast'
alias show-pg-status='pg_ctl status'
alias restart-pg='pg_ctl reload'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# For building the mysql2 gem, not sure what the best solution is
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

PATH=/Users/nikhil/Library/Python/2.7/bin:$PATH
PATH=/Users/nikhil/Library/Python/3.7/bin:$PATH
export PATH

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

eval "$(rbenv init -)"
export PATH="./bin:$PATH"

# alias standup = 'open -a "Google Chrome" https://meet.google.com/kwg-gpmk-zbc'

source $HOME/.cargo/env
