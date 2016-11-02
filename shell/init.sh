# Sourced by .zshrc and .bashrc
#
# Files sourced by init.sh should be shell-agnostic, i.e.
# the commands in the sourced file should work in
# both zsh and bash.

source "${DOTFILES}/shell/path.sh"
source "${DOTFILES}/shell/os.sh"
source "${DOTFILES}/shell/functions.sh"
source "${DOTFILES}/shell/aliases.sh"

# Node
source "${DOTFILES}/shell/node.sh"

# Python
source "${DOTFILES}/shell/python.sh"

# Ruby
source "${DOTFILES}/shell/ruby.sh"
