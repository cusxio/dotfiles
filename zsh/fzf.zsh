export FZF_COMPLETION_TRIGGER=";"
export FZF_PATH_LOC=""

FZF_FILE_HIGHLIGHTER="cat"
(( $+commands[highlight] )) && FZF_FILE_HIGHLIGHTER="highlight -lO ansi"
(( $+commands[bat] )) && FZF_FILE_HIGHLIGHTER="bat --color=always"

FZF_DIR_HIGHLIGHTER="ls -l --color=always"
(( $+commands[tree] )) && FZF_DIR_HIGHLIGHTER="tree -CtrL2"
(( $+commands[exa] )) && FZF_DIR_HIGHLIGHTER="exa --color=always -TL2"

# DEFAULT
(( $+commands[fd] )) && export FZF_DEFAULT_COMMAND="fd --type f --follow --hidden --exclude .git"
export FZF_DEFAULT_OPTS="
  --border
  --ansi
  --prompt \"${PURE_PROMPT_SYMBOL:->} \"
  --tabstop 2
  --margin 1,1,0,1
  --cycle
  --preview \"($FZF_FILE_HIGHLIGHTER {} || $FZF_DIR_HIGHLIGHTER {}) 2>/dev/null | head -200\"
  --bind ?:toggle-preview
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 
"

# CTRL-T
(( $+commands[fd] )) && export FZF_CTRL_T_COMMAND="fd --type f --type d --follow --hidden --exclude .git"
export FZF_CTRL_T_OPTS="
  --preview \"($FZF_FILE_HIGHLIGHTER {$FZF_PATH_LOC} || $FZF_DIR_HIGHLIGHTER {$FZF_PATH_LOC}) 2>/dev/null | head -200\"
  --bind 'enter:execute(echo {$FZF_PATH_LOC})+abort'
  --bind 'alt-e:execute($EDITOR {$FZF_PATH_LOC} >/dev/tty </dev/tty)'
  --bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+$FZF_PATH_LOC} | pbcopy)+abort\"
"

# CTRL-R
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window down:2:hidden:wrap
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'Press CTRL-Y to copy command into clipboard'
  --reverse
"

# ALT-C
(( $+commands[fd] )) && FZF_ALT_C_COMMAND="fd --type d --follow --hidden --exclude .git"
(( $+commands[blsd] )) && FZF_ALT_C_COMMAND="blsd $dir"
export FZF_ALT_C_COMMAND
export FZF_ALT_C_OPTS="
  --exit-0
  --bind 'enter:execute(echo {$FZF_PATH_LOC})+abort'
  --preview '($FZF_DIR_HIGHLIGHTER {$FZF_PATH_LOC}) | head -200 2>/dev/null'
  --preview-window=right:50%
"
