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

fv() {
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

fs() {
    local session
    session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session"
}

# Git Itegrations
fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fco() {
    local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all | grep -v HEAD             |
        sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
        sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
        fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
    git checkout $(echo "$target" | awk '{print $2}')
}

fcoc() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
}

flog() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
            (grep -o '[a-f0-9]\{7\}' | head -1 |
            xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
            {}
            FZF-EOF"
}

fstash() {
    local out q k sha
    while out=$(
        git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
        fzf --ansi --no-sort --query="$q" --print-query \
            --expect=ctrl-d,ctrl-b);
    do
        mapfile -t out <<< "$out"
        q="${out[0]}"
        k="${out[1]}"
        sha="${out[-1]}"
        sha="${sha%% *}"
        [[ -z "$sha" ]] && continue
        if [[ "$k" == 'ctrl-d' ]]; then
            git diff $sha
        elif [[ "$k" == 'ctrl-b' ]]; then
            git stash branch "stash-$sha" $sha
            break;
        else
            git stash show -p $sha
        fi
    done
}

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

atom_save_pkg() {
    apm list --installed --bare > ~/.dotfiles/atom/atom_packages.txt
}
