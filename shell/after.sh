# FZF
# https://github.com/junegunn/fzf
export FZF_COMPLETION_TRIGGER=';'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# colorscheme to match gruvbox
# export FZF_DEFAULT_OPTS='
#   --color prompt:214,hl+:220,pointer:220,hl:214
# '
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# http://www.andre-simon.de/doku/highlight/en/highlight.php
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Editor

export EDITOR="nvim"
