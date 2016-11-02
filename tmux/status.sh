__run_ruby() {
    echo "v$RUBY_VERSION"
}

__run_node() {
    echo "$(node -v)"
}

__status() {
    declare -r OPEN_BRACKET="#[fg=colour237]["
    declare -r CLOSE_BRACKET="#[fg=colour237]]"

    declare -r RUBY_STATUS="${OPEN_BRACKET}#[fg=colour160] $(__run_ruby) ${CLOSE_BRACKET}"

    declare -r NODE_STATUS="${OPEN_BRACKET}#[fg=yellow] $(__run_node) ${CLOSE_BRACKET}"

    declare -r TIME="${OPEN_BRACKET}#[fg=colour240] $(date +'%a, %d/%m %H:%M') ${CLOSE_BRACKET}"

    echo "${RUBY_STATUS}${NODE_STATUS}${TIME}"
}

__status
