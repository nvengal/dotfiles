# zshrc

export HISTSIZE=1000000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# Vim mode
bindkey -v

# Load git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

#################### FZF ######################################################
# Override path completion to use fd
_fzf_compgen_path() {
  echo "$1"
  command fd --hidden --follow --exclude .git . $1
}

# Override dir completion to use fd
_fzf_compgen_dir() {
  command fd --type d --hidden --follow --exclude .git . $1
}

# Default to fzf for path completion
export FZF_COMPLETION_TRIGGER='.'
# Use fd for fzf (respects gitignore and other niceties)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && \
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
#################### FZF ######################################################

eval "$(mise activate zsh)"
eval "$(starship init zsh)"
