# Sourced by shell/init.sh

export CHRUBY_PREFIX="${BREW_PREFIX:-/usr}"

[ -s "${CHRUBY_PREFIX}/share/chruby/chruby.sh" ] && source "${CHRUBY_PREFIX}/share/chruby/chruby.sh"

[ -s "${CHRUBY_PREFIX}/share/chruby/chruby.sh" ] && source "${CHRUBY_PREFIX}/share/chruby/auto.sh"