# Sourced by shell/init.sh

command -v "pyenv" &> /dev/null && {
    eval "$(pyenv init -)"
}

command -v "pyenv-virtualenv-init" &> /dev/null && {
    eval "$(pyenv virtualenv-init -)"
}
