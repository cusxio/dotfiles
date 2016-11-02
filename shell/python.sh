# Sourced by shell/init.sh

export PYENV_ROOT="${HOME}/.local/pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"

command -v "pyenv" &> /dev/null && {
    eval "$(pyenv init -)"
}

command -v "pyenv-virtualenv-init" &> /dev/null && {
    eval "$(pyenv virtualenv-init -)"
}
