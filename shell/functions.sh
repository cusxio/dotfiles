# Sourced by shell/init.sh
#
# Add utility functions that can be used by all types of
# shell here.

# Recursively make directory and cd into it automatically.
mkcd () {
    case "$1" in
        */..|*/../)    cd -- "$1";;

        /*/../*)      (cd "${1%/../*}/.." && \
                       mkdir -p "./${1##*/../}") \
                       && cd -- "$1";;

        /*)            mkdir -p "$1" && cd "$1";;

        */../*)       (cd "./${1%/../*}/.." && \
                       mkdir -p "./${1##*/../}") && \
                       cd "./$1";;

        ../*)         (cd .. && mkdir -p "${1#.}") && \
                       cd "$1";;

        *)            mkdir -p "./$1" && cd "./$1";;
    esac
}

# FZF

v() {
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vim "${file}" || return 1
}

# Changing directory with fasd.
# Same as z, but displays a fzf prompt when no arguments
# are provided.
fz() {
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# FUTURE: Checkout some FZF git functions.

# fasd

# Same as z, but jumps to previous directory when no arguments
# are provided.
j() {
    if [ "$#" -gt 0 ]; then
        fasd_cd -d $1
    else
        cd -
    fi
}

# Docker

function denv() {
    eval "$(docker-machine env "${1:-default}")"
}

function dic() {
    docker rmi -f $(docker images -q -a -f dangling=true)
}

function dri() {
    docker rmi $(docker images -q)
}

# Atom

save_atom_pkg () {
    apm list --installed --bare > ~/.dotfiles/atom/atom_packages.txt
}
