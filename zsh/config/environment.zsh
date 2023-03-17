autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

setopt CORRECT
setopt NO_BEEP

(( $+commands[nvim] )) && export EDITOR=nvim || export EDITOR=vim
export VISUAL=$EDITOR

export GATSBY_TELEMETRY_DISABLE=1

# Homebrew
if (( $+commands[brew] )); then
  export BREW_PREFIX="$(brew --prefix)"
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_INSECURE_REDIRECT=1
  # export HOMEBREW_CASK_OPTS="--require-sha"
fi

(( $+commands[bat] )) && export BAT_THEME="Catppuccin-mocha"

export LANG='en_US.UTF-8'
