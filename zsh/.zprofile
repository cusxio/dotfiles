typeset -gU cdpath path fpath manpath

cdpath=(
  $cdpath
)

fpath=(
  ${BREW_PREFIX:-/usr/local}/share/zsh/site-functions(N-/)
  $fpath
)

path=(
  ${DOTFILES}/bin(N-/)
  # ${BREW_PREFIX:-/usr/local}/opt/{coreutils,findutils}/libexec/gnubin(N-/)
  ${HOME}/.yarn/bin(N-/)
  # seems to be required by homebrew
  /usr/local/sbin
  $path
)

manpath=(
  ${BREW_PREFIX:-/usr/local}/opt/{coreutils,findutils}/libexec/gnuman(N-/)
  $manpath
)
