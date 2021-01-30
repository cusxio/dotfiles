for config (${ZDOTDIR}/config/*.zsh) source $config

declare -A ZINIT

function {
  ZINIT[HOME_DIR]="$XDG_CACHE_HOME/zsh/zinit"
  ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/bin"
  ZINIT[PLUGINS_DIR]="$ZINIT[HOME_DIR]/plugins"
  ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zsh/.zcompdump"

  export ZPFX="$ZINIT[HOME_DIR]/polaris"

  local __ZINIT="$ZINIT[BIN_DIR]/zinit.zsh"

  if [[ ! -f "$__ZINIT" ]]; then
    if (( $+commands[git] )); then
      git clone https://github.com/zdharma/zinit.git "$ZINIT[BIN_DIR]"
    else
      echo 'git not found' >&2
      exit 1
    fi
  fi

  source "$__ZINIT"

  (( $+commands[git] )) && {
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit
    source "${ZDOTDIR}/zinit.zsh"
  }
}

# fzf
if (( $+commands[fzf] )); then
  source "${BREW_PREFIX:-/usr/local}/opt/fzf/shell/completion.zsh"
  source "${BREW_PREFIX:-/usr/local}/opt/fzf/shell/key-bindings.zsh"
  source "${ZDOTDIR}/fzf.zsh"
fi

if (( $+commands[mkcert] )) && [[ -f "${XDG_DATA_HOME}/mkcert/rootCA.pem" ]]; then
  # export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
  # calling `mkcert -CAROOT` is extremely slow
  export NODE_EXTRA_CA_CERTS="${XDG_DATA_HOME}/mkcert/rootCA.pem"
fi

# nvm
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# fnm
if (( $+commands[fnm] )); then
  eval "$(fnm env)"
fi
