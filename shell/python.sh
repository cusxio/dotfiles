# Sourced by shell/init.sh

export PYENV_ROOT="${HOME}/.pyenv"

command -v "pyenv" &> /dev/null && {
    eval "$(pyenv init -)"
}

command -v "pyenv-virtualenv-init" &> /dev/null && {
    eval "$(pyenv virtualenv-init -)"
}