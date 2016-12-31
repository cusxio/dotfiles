# Sourced by shell/vars.sh
#
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
#
# Setups a few environment variable based on the specifications

[ -n "$SOURCED_XDG" ] && return export SOURCED_XDG=1

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

export XDG_CACHE_HOME="${HOME}/.cache"

export XDG_DATA_HOME="${HOME}/.local/share"
