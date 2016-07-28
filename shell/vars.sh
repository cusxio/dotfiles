# Sourced by zsh/.zshenv

source "${HOME}/.dotfiles/shell/xdg.sh"

# DOTFILES
export DOTFILES="${HOME}/.dotfiles"
export ZDOTDIR="${DOTFILES}/zsh"

# History
export SAVEHIST=10000
export HISTSIZE=10000
 #ignorespace:ignoredups
export HISTCONTROL=ignoreboth
# HISTIGNORE ?

# Atom
export ATOM_HOME="${XDG_CONFIG_HOME}/atom"

# Homebrew Analytics
# https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# FZF
# https://github.com/junegunn/fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Go
export GOPATH="${HOME}/go"