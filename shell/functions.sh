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

denv() {
    eval "$(docker-machine env "${1:-default}")"
}

dic() {
    docker rmi -f $(docker images -q -a -f dangling=true)
}

dri() {
    docker rmi $(docker images -q)
}

# Atom

save_atom_pkg () {
    apm list --installed --bare > ~/.dotfiles/atom/atom_packages.txt
}

colorgrid() {
    iter=16
    while [ $iter -lt 52 ]
    do
        second=$[$iter+36]
        third=$[$second+36]
        four=$[$third+36]
        five=$[$four+36]
        six=$[$five+36]
        seven=$[$six+36]
        if [ $seven -gt 250 ];then seven=$[$seven-251]; fi

        echo -en "\033[38;5;$(echo $iter)m█ "
        printf "%03d" $iter
        echo -en "   \033[38;5;$(echo $second)m█ "
        printf "%03d" $second
        echo -en "   \033[38;5;$(echo $third)m█ "
        printf "%03d" $third
        echo -en "   \033[38;5;$(echo $four)m█ "
        printf "%03d" $four
        echo -en "   \033[38;5;$(echo $five)m█ "
        printf "%03d" $five
        echo -en "   \033[38;5;$(echo $six)m█ "
        printf "%03d" $six
        echo -en "   \033[38;5;$(echo $seven)m█ "
        printf "%03d" $seven

        iter=$[$iter+1]
        printf '\r\n'
    done
}
