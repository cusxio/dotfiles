# $ZDOTDIR/.zshenv
# $ZDOTDIR/.zprofile
# $ZDOTDIR/.zshrc
# $ZDOTDIR/.zlogin
# $ZDOTDIR/.zlogout

export ZDOTDIR="${${(%):-%N}:A:h}"
export DOTFILES="${HOME}/Documents/dev/dotfiles"

# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME_HOME:-$HOME/.local/share}

# nvm
# export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

# fnm
export FNM_DIR="${XDG_CONFIG_HOME}/fnm"

# yarn
export YARN_CACHE_FOLDER="${XDG_CACHE_HOME}/yarn"

# pnpm
export PNPM_HOME="${XDG_DATA_HOME}/pnpm"

# babel
export BABEL_CACHE_PATH="${XDG_CACHE_HOME}/babe/babel.json"

# zoxide
export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"

# git-fuzzy
export GF_SNAPSHOT_DIRECTORY="${XDG_DATA_HOME}/git-fuzzy-snapshots"

# rust
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

if [[ -f "$XDG_DATA_HOME/cargo/env" ]]; then
  source "$XDG_DATA_HOME/cargo/env"
fi

# tree-sitter
export TREE_SITTER_DIR="${XDG_CONFIG_HOME}/tree-sitter"

# neovim
export NVIM_APPNAME="nvim"
