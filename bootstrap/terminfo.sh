#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit 1

declare -r DOTFILES_PATH="$(pwd)"

source "${DOTFILES_PATH}/library/logger.sh"

__terminfo() {
    logger::action "Setting up terminfo"

    find "${DOTFILES_PATH}/terminfo/" -name '*.terminfo' -exec tic -x {} \;

    logger::result $? "terminfo setup"
}

__terminfo