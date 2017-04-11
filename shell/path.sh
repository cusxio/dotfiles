# Sourced by shell/init.sh

# To know the default path in macOS, run
# man path_helper
# According to the man, macOS determines the paths
# from /etc/paths

if [[ -n "$OXYGEN_SYSTEM_PATH" ]]; then
    export OXYGEN_SYSTEM_PATH="${PATH}:${OXYGEN_SYSTEM_PATH}"
else
    export OXYGEN_SYSTEM_PATH="${PATH}"
fi

COMPOSED_PATH=$OXYGEN_SYSTEM_PATH

COMPOSED_PATH="/usr/local/sbin:${OXYGEN_SYSTEM_PATH}"

# Go
COMPOSED_PATH="${GOPATH}/bin:${COMPOSED_PATH}"

# Postgres.app
if [[ -d "/Applications/Postgres.app/Contents/Versions/latest/bin" ]]; then
    COMPOSED_PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:${COMPOSED_PATH}"
fi

# Local
COMPOSED_PATH="${DOTFILES}/bin:${COMPOSED_PATH}"

export PATH=$COMPOSED_PATH
