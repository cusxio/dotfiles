# Logger
# Sourced Only.

COL_START="\x1b["
COL_END="\x1b[m"

COL_RED=$COL_START"0;31m"
COL_GREEN=$COL_START"0;32m"
COL_YELLOW=$COL_START"0;33m"
COL_BLUE=$COL_START"0;34m"
COL_MAGENTA=$COL_START"0;35m"
COL_CYAN=$COL_START"0;36m"
COL_WHITE=$COL_START"0;37m"

COL_RED_BOLD=$COL_START"1;31m"
COL_GREEN_BOLD=$COL_START"1;32m"
COL_BLUE_BOLD=$COL_START"1;34m"

logger::human() {
    printf "$COL_BLUE_BOLD$1$COL_END"
}

logger::action() {
    printf "\n$COL_RED_BOLD==> $1$COL_END\n\n"
}

logger::success() {
    printf "  $COL_GREEN[ok] $1$COL_END\n"
}

logger::warning() {
    printf "  $COL_YELLOW[!] $1$COL_END\n"
}

logger::error() {
    printf "  $COL_RED[x] $1$COL_END\n"
}

logger::info() {
    printf "  $COL_MAGENTA[i] $1$COL_END\n"
}

logger::complete() {
    printf "\n$COL_GREEN_BOLD==> $1$COL_END\n\n"
}

logger::result() {
    if [[ "$1" -eq 0 ]]; then
        logger::success "$2"
    else
        logger::error "$2"
    fi

    return "$1"
}