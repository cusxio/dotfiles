__run_ruby() {
    echo "v$RUBY_VERSION"
}

__run_node() {
    echo "$(node -v)"
}

__status() {
    # gruvbox: colour237
    declare -r OPEN_BRACKET="#[fg=blue]["
    declare -r CLOSE_BRACKET="#[fg=blue]]"

    declare -r RUBY_STATUS="${OPEN_BRACKET}#[fg=red] $(__run_ruby) ${CLOSE_BRACKET}"

    declare -r NODE_STATUS="${OPEN_BRACKET}#[fg=yellow] $(__run_node) ${CLOSE_BRACKET}"

    # gruvbox: colour240
    declare -r TIME="${OPEN_BRACKET}#[fg=magenta] $(date +'%a, %d/%m %H:%M') ${CLOSE_BRACKET}"

    echo "${RUBY_STATUS}${NODE_STATUS}${TIME}"
}

__status
