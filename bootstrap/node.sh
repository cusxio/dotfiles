#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit 1

declare -r DOTFILES_PATH="$(pwd)"

source "${DOTFILES_PATH}/library/logger.sh"
source "${DOTFILES_PATH}/library/requires.sh"

__npm_install_g() {
    declare -ar NPM_PACKAGES=(
        "gulp"
        "babel-cli"
        "eslint"
        "superstatic"
        "npm-check-updates"
        "speed-test"
        "surge"
        "now"
        "lighthouse"
        "cost-of-modules"
        "browser-sync"
    )
    for package in "${NPM_PACKAGES[@]}"; do
        require::npm "$package"
    done
}

__node_default() {
    nvm alias default "lts/boron" &> /dev/null
    logger::result $? "nvm alias default lts/boron"
    nvm use "lts/boron" &> /dev/null
}

__node_install() {
    declare -ar NODE_VERIONS=(
        # LTS
        "--lts=boron"

        # aka latest
        "node"
    )
    for version in "${NODE_VERIONS[@]}"; do
        require::node "$version"
    done
}

__nvm_update() {
    logger::action "Updating existing NVM"
    cd "$NVM_DIR" && \
        git fetch origin && \
        git checkout `git describe --abbrev=0 --tags`
    if [[ $? = 0 ]]; then
        source "${NVM_DIR}/nvm.sh"
        logger::success "NVM Update"
    else
        logger::error "NVM Update"
    fi
}

__check_nvm_installation() {
    if [[ -d "$NVM_DIR/.git" ]]; then
        logger::warning "NVM is already installed"
        __nvm_update
    else
        mkdir -p "$NVM_DIR"
        git clone --quiet "$NVM_GIT_URL" "$NVM_DIR" && \
            cd "$NVM_DIR" && \
            git checkout `git describe --abbrev=0 --tags`
        if [[ $? = 0 ]]; then
            logger::result $? "NVM Installed"
            source "${NVM_DIR}/nvm.sh"
        fi
    fi
}

__nvm() {
    declare -r NVM_DIR="${XDG_CONFIG_HOME}/nvm"
    declare -r NVM_GIT_URL="https://github.com/creationix/nvm.git"
    logger::action "NVM"
    __check_nvm_installation
    logger::action "Node <3"
    __node_install
    logger::action "Setting a default Node version"
    # Setting node lts/boron as the default version.
    __node_default
    logger::action "NPM Global Packages"
    __npm_install_g
    logger::complete "[OK] node.sh initilization complete"
}

__nvm
