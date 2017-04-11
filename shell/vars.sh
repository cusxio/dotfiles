# Sourced by zsh/.zshenv

source "${HOME}/.dotfiles/shell/xdg.sh"

# Locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

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

# Prompt - λ ▴ ⚡ Δ ⇒ › ϟ ↯
export PURE_PROMPT_SYMBOL='λ'

# Go
export GOPATH="${HOME}/go"
