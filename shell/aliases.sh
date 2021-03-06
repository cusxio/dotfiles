# Sourced by shell/init.sh

# Change Directory
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias cd.="cd .."
alias cd..="cd .."
alias cdd="cd \"\${DOTFILES}\""

# List Directory
alias ls="ls -G"
alias l="ls -alF"
alias ll="ls -l"

# NPM
alias nlg="npm list -g --depth=0"
alias ni="npm install"
alias nig="npm install -g"
alias nid="npm install --save"
alias nidd="npm install --save-dev"
alias nudd="npm uninstall --save-dev"
alias nud="npm uninstall --save"
alias ns="npm start"
alias nrb="npm run build"
alias nrc="npm run clean"

# yarn
alias yad="yarn add"
alias yadd="yarn add --dev"
alias yc="yarn check"
alias yci="yarn check --integrity"
alias yout="yarn outdated"
alias yup="yarn upgrade"
alias ys="yarn start"

# git
alias gc="git clone"
alias gd="git diff"
alias gdsf="git dsf"
alias ga="git add"
alias gst="git status"
alias gcm="git commit"
alias gcmm="git commit -m"
alias gcmam="git commit -a -m"
alias gcmne="git commit --amend --no-edit"
alias gm="git merge --no-ff"
alias gpt="git push --tags"
alias gp="git push"
alias gpo="git push origin"
alias grh="git reset --hard"
alias gb="git branch"
alias gbd="git branch -D"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gba="git branch -a"
alias gcp="git cherry-pick"
alias gl="git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph"
alias gpl="git pull"
alias gplom="git pull origin master"
alias gcd='cd "`git rev-parse --show-toplevel`"'
alias git="hub"
alias gsl="git stash list"

# Docker
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias di="docker images"
alias dps="docker ps"
alias dpa="docker ps -a"
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias dcb="docker-compose build"
alias dcu="docker-compose up"

# Editors
type nvim >/dev/null 2>&1 && alias v='nvim'

# Open working directory
alias aa='atom .'
alias ss='subl .'
alias oo='open .'

# Tmux
alias tmux="tmux -f ${DOTFILES}/tmux/config.conf"
alias tls="tmux ls"
alias ta="tmux attach -t"
alias tns="tmux new-session -s"
alias tk="tmux kill-session -t"
alias trw="tmux rename-window"
alias td="tmux detach"

# Commands
alias rmrf="rm -rf"
alias cls="clear"
alias exe="chmod +x"
alias tree="tree -C -a --dirsfirst -I '.git|node_modules|.DS_Store'"
command -v "rmtrash" &> /dev/null && alias trash="rmtrash"

# Servers
alias pserver="open http://localhost:8000 && python -m SimpleHTTPServer"
alias nserver="http-server -o -p 8001"
