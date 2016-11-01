#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit 1

declare -r DOTFILES_PATH="$(pwd)"

source "${DOTFILES_PATH}/library/logger.sh"
source "${DOTFILES_PATH}/library/requires.sh"

declare -r P2_LATEST="$(pyenv install -l | grep -e '2.7.[0-9]' | grep -v - | tail -1)"
declare -r P3_LATEST="$(pyenv install -l | grep -e '3.5.[0-9]' | grep -v - | tail -1)"

__python_neovim_env() {
    local P2_VERSION=$(echo $P2_LATEST) # to remove whitespace
    local P3_VERSION=$(echo $P3_LATEST)
    pyenv virtualenv $P2_VERSION neovim2 &> /dev/null
    logger::result $? "pyenv-virtualenv $P2_VERSION neovim2"
    logger::human "   -> env most likely already exists.\n"
    pyenv virtualenv $P3_VERSION neovim3 &> /dev/null
    logger::result $? "pyenv-virtualenv $P3_VERSION neovim3"
    logger::human "   -> env most likely already exists.\n"
}

__python_install() {
    local P2_VERSION=$(echo $P2_LATEST) # to remove whitespace
    local P3_VERSION=$(echo $P3_LATEST)
    require::python $P2_VERSION
    require::python $P3_VERSION
}

_check_pyenv_installation() {
    brew ls | grep "pyenv" &> /dev/null
    if [[ $? != 0 ]]; then
        require::brew "pyenv"
        require::brew "pyenv-virtualenv"
    else
        logger::warning "Pyenv is already installed"
    fi
}

_python() {
    logger::action "Pyenv"
    _check_pyenv_installation
    logger::action "Python"
    __python_install
    logger::action "Setting up python environment"
    __python_neovim_env
    logger::complete "[OK] python.sh initilization complete"
}

_python