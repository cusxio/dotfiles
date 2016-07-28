# Requires
# Sourced Only.

require::brew() {
    # http://unix.stackexchange.com/questions/14270/get-exit-status-of-process-thats-piped-to-another/73180#73180
    brew list $1 &> /dev/null | true

    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        brew install $1

        if [[ $? != 0 ]]; then
            logger::error "Failed to install brew $1 !"
        else
            logger::success "Installed brew $1 !"
        fi
    else
        logger::info "brew $1 is already installed"
    fi
}

require::cask() {
    # http://unix.stackexchange.com/questions/14270/get-exit-status-of-process-thats-piped-to-another/73180#73180
    brew cask list $1 &> /dev/null | true

    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        brew cask install $1

        if [[ $? != 0 ]]; then
            logger::error "Failed to install cask $1 !"
        else
            logger::success "Installed brew $1 !"
        fi
    else
        logger::info "brew cask $1 is already installed"
    fi
}

require::python() {
    pyenv versions | grep "$1" &> /dev/null

    if [[ $? != 0 ]]; then
        pyenv install $1

        if [[ $? != 0 ]]; then
            logger::error "Failed to install python $1 !"
        else
            logger::success "Installed python $1 !"
        fi
    else
        logger::info "python $1 is already installed"
    fi
}

__nvm_install() {
    nvm install $1 &> /dev/null

    if [[ $? != 0 ]]; then
        logger::error "Failed to install node $1 !"
    else
        logger::success "Installed node $1 !"
    fi
}

require::node() {
    command -v "brew" &> /dev/null
    if [[ $? != 0 ]]; then
        source ~/.zshenv
        __nvm_install $1
    else
        __nvm_install $1
    fi
}

require::npm() {
    npm list -g --depth 0 | grep $1 &> /dev/null

    if [[ $? != 0 ]]; then
        npm install -g $1
        logger::result $? "npm install -g $1"
    else
        logger::error "npm install -g $1 is already installed !"
    fi

}