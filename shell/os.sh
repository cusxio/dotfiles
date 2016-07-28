# Sourced by shell/init.sh

case "$(uname -s)" in
    Darwin)    export OXYGEN_SYSTEM_OS="Darwin"  ;;
    *)         export OXYGEN_SYSTEM_OS="Linux"   ;;
esac

# macOS

if [[ $OXYGEN_SYSTEM_OS = "Darwin" ]]; then
    command -v "brew" &> /dev/null
    if [[ $? = 0 ]]; then
        export BREW_PREFIX="$(brew --prefix)"
    fi
fi