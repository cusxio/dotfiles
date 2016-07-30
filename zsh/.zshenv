# http://zsh.sourceforge.net/Intro/intro_3.html
#
# Read about ZDOTDIR and startup sequence


source "${HOME}/.dotfiles/shell/vars.sh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
export HISTFILE="${ZDOTDIR}/.zsh_history"

# This ensures that all plugins are loaded for tmux.
unset ZPLUG_ROOT
