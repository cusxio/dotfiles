zinit ice pick"async.zsh" src"pure.zsh"
zinit light "cusxio/pure"
zstyle :prompt:pure:path color 240
zstyle :prompt:pure:git:branch color 240
zstyle :prompt:pure:git:dirty color yellow
zstyle :prompt:pure:prompt:success color yellow

SYMBOLS=(
  "λ"
  "▴"
  "Δ"
  "»"
  "৸"
  # "ϟ"
  # "⚡"
  "↯"
  "⇒"
  "›"
)

ERROR_SYMBOLS=(
  "⎋"
  "⊘"
  "⊗"
  "×"
)

# export PURE_PROMPT_SYMBOL="${SYMBOLS[$RANDOM % ${#SYMBOLS[@]}]}"
export PURE_PROMPT_SYMBOL="ϟ"
export PURE_PROMPT_SYMBOL_ERROR="${ERROR_SYMBOLS[$RANDOM % ${#ERROR_SYMBOLS[@]}]}"

zinit ice wait blockf lucid atpull"zinit creinstall -q ."
zinit light "zsh-users/zsh-completions"

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
  atload"unset 'FAST_HIGHLIGHT[chroma-whatis]' 'FAST_HIGHLIGHT[chroma-man]'"
zinit light "zdharma/fast-syntax-highlighting"

zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light "zsh-users/zsh-autosuggestions"

zinit ice wait lucid trigger-load'!man'
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# export NVM_LAZY_LOAD=true
# zinit ice wait lucid
# zinit light lukechilds/zsh-nvm

zinit ice wait lucid from'gh-r' as'program' mv'zoxide* -> zoxide' atclone'echo "unalias zi 2> /dev/null " > zhook.zsh && ./zoxide init zsh --hook pwd >> zhook.zsh' atpull'%atclone' src'zhook.zsh'
zinit light ajeetdsouza/zoxide

zinit ice wait lucid as'command' pick'bin/git-fuzzy'
zinit light bigH/git-fuzzy
