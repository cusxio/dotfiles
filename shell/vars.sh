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
export FZF_DEFAULT_OPTS='
  --color prompt:214,hl+:220,pointer:220,hl:214
'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_CTRL_T_OPTS='--preview "(([[ "{}" =~ \.twig$ ]] &&  highlight -S html -O ansi -l {} 2> /dev/null || highlight -O ansi -l {} 2> /dev/null) || cat {} || tree -C {}) 2> /dev/null | head -200" --bind "?:toggle-preview,alt-k:preview-page-up,alt-j:preview-page-down"'

# Go
export GOPATH="${HOME}/go"