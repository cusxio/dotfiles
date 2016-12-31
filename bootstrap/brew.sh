#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit 1

declare -r DOTFILES_PATH="$(pwd)"

source "${DOTFILES_PATH}/library/logger.sh"
source "${DOTFILES_PATH}/library/requires.sh"

__brew_install_casks() {
    declare -ar CASKS=(
        # Apps
        "atom"
        "google-chrome"
        "vlc"
        "transmission"
        "iterm2-nightly"
        "keka"
        "evernote"
        "teamviewer"
        "dropbox"
        "hammerspoon"
        "spotify"
        "spotifree"
        "hyper"
        "imageoptim"
        "visual-studio-code"
        "kap"
        "appcleaner"

        # Quicklook
        # https://github.com/sindresorhus/quick-look-plugins
        "qlcolorcode"
        "qlstephen"
        "qlmarkdown"
        "quicklook-json"
        "qlprettypatch"
        "quicklook-csv"
        "betterzipql"
        "qlimagesize"
        "webpquicklook"
        "suspicious-package"
    )

    for cask in "${CASKS[@]}"; do
        require::cask "$cask"
    done
}

__check_caskroom_installation() {
    brew tap | grep "caskroom" &> /dev/null
    if [[ $? != 0 ]]; then
        brew tap caskroom/cask
        brew tap caskroom/versions
        logger::success "Caskroom install complete"
    else
        logger::warning "Caskroom is already installed"
    fi
}

__brew_install_formulas() {
    declare -ar FORMULAS=(
        # Tools/Binaries/Liraries
        "coreutils"
        "moreutils"
        "findutils"
        "automake"
        "cmake"
        "openssl"

        # Filesystem
        "fasd"
        "the_silver_searcher"
        "fzf"
        "tree"
        "rmtrash"
        "ripgrep"

        # VCS
        "git"
        "git-extras"
        "hub"
        "diff-so-fancy"

        # Shells
        "zsh"
        "bash"
        "bash-completion"
        "tmux"

        # Programming
        # "pyenv"
        # "pyenv-virtualenv"
        "go"
        "python"
        "python3"
        "chruby"
        "ruby-install"

        # Editors
        "vim --with-override-system-vim --with-python3"
        "neovim/neovim/neovim"

        # Misc.
        "cowsay"
        "wifi-password"
        "tree"
        "mas"
        "youtube-dl"
    )

    for formula in "${FORMULAS[@]}"; do
        require::brew "$formula"
    done
}

__brew_update() {
    logger::action "Updating existing Homebrew"
    brew update
    logger::result $? "Homebrew update"
}

__brew_upgrade() {
    logger::action "Upgrading existing Homebrew formulas"
    brew upgrade
    logger::result $? "Homebrew formulas upgrade"
}

__check_brew_installation() {
    brew_bin=$(which brew) 2>&1 > /dev/null
    if [[ $? != 0 ]]; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

        if [[ $? != 0 ]]; then
            logger::error "Unable to install homebrew, script $0 abort!"
            exit 2
        else
            logger::success "Homebrew install complete"
        fi
    else
        logger::warning "Homebrew is already installed"
        __brew_update
        __brew_upgrade
    fi
}

__brew() {
    logger::action "Homebrew"
    __check_brew_installation
    logger::action "Homebrew formulas"
    __brew_install_formulas
    logger::action "Caskroom"
    __check_caskroom_installation
    logger::action "Caskroom casks"
    __brew_install_casks
    logger::complete "[OK] brew.sh initilization complete"
}

__brew
