HISTFILE="${XDG_DATA_HOME:-$HOME}/.zsh_history"

HISTSIZE=10000
SAVEHIST=$HISTSIZE

HISTORY_IGNORE="(ls|ls *|l|ll|cd|cd -|-|clear|c|pwd|exit|date|* --help|gst)"

setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
