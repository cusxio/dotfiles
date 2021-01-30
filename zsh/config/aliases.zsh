alias "?"="pwd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

if (( $+commands[exa] )); then
  alias ls="exa"
  alias tree="exa -T"
fi

alias l='ls -F'
alias ll='ls -laF'

alias c="clear"

alias gc="git clone"
alias gst="git status"
alias gd="git diff"
alias gca="git commit -a -m"
alias gp="git push"
alias gpo="git push origin"
alias gco="git checkout"
alias gcob="git checkout -b"
