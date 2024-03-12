# nvim
export NVIM_APPNAME="nvchad"

# xdg
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME_HOME:-$HOME/.local/share}
export npm_config_cache="{$XDG_CACHE_HOME}/npm"

# pnpm
export PNPM_HOME="${XDG_DATA_HOME}/pnpm"

# zoxide
export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"

# zellij
export ZELLIJ_CONFIG_DIR="${XDG_CONFIG_HOME}/zellij"

if (( $+commands[eza] )); then
  alias ls="eza"
  alias ld="eza -lD"
  alias ll="eza -al --group-directories-first"
  alias tree="eza -T"
fi

(( $+commands[nvim] )) && export EDITOR="nvim"

eval "$(mise activate zsh)"

eval "$(zoxide init zsh)"

# source <(pkgx --shellcode)
