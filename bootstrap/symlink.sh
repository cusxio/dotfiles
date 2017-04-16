#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/.." || exit 1

declare -r DOTFILES_PATH="$(pwd)"

source "${DOTFILES_PATH}/library/logger.sh"

# Symlink Helper function
__symlink_helper() {
    local SOURCE_FILE="$DOTFILES_PATH/$1"
    local TARGET_PATH="$HOME/$2"

    mkdir -p "$(dirname "$TARGET_PATH")"

    ln -fns "$SOURCE_FILE" "$TARGET_PATH"

    logger::result $? "$1 ---> $2"
}

_symlink() {
    logger::action "Symlinking dotfiles"

    # git
    __symlink_helper git/gitconfig      .config/git/config
    __symlink_helper git/gitignore      .config/git/ignore

    # atom
    __symlink_helper atom/config.cson      .config/atom/config.cson
    __symlink_helper atom/init.coffee      .config/atom/init.coffee
    __symlink_helper atom/keymap.cson      .config/atom/keymap.cson
    __symlink_helper atom/snippets.cson    .config/atom/snippets.cson
    __symlink_helper atom/styles.less      .config/atom/styles.less

    # hyper.app
    __symlink_helper hyper/dot.hyper.js    .hyper.js

    # vim
    __symlink_helper vim           .vim
    __symlink_helper vim           .config/nvim
    __symlink_helper vim/vimrc     .config/nvim/init.vim

    # spacemacs
    __symlink_helper spacemacs     .spacemacs.d

    # zsh
    __symlink_helper zsh/.zshenv   .zshenv

    # sass-lint
    __symlink_helper sass-lint/dot.sass-lint.yml .config/sass-lint/.sass-lint.yml

    # tern-project
    __symlink_helper tern/dot.tern-config      .tern-project

    case "$OSTYPE" in
        darwin*)
            __symlink_helper mac/hushlogin    .hushlogin
        ;;
    esac
}

_symlink
