#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/.." || exit 1

declare -r DOTFILES_PATH="$(pwd)"

source "${DOTFILES_PATH}/library/logger.sh"

logger::action "Installing XCode"

if type xcode-select >&- && \
    xpath=$( xcode-select --print-path ) && \
    test -d "${xpath}" && \
    test -x "${xpath}"; then
    logger::success "XCode Command Line Tools"
    logger::success "XCode License Accepted"
else
    xcode-select --install &> /dev/null

    until __is_xcode_installed; do
        sleep 5
    done

    logger::success "XCode Command Line Tools"

    sudo xcodebuild -license accept

    logger::success "XCode License Accepted"
fi


__is_xcode_installed() {
    xcode-select --print-path &> /dev/null
}
