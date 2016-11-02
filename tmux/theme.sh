# ----------------------
# Status Bar
# -----------------------

# turn the status bar on
set-option -g status on

# visual notification of activity in other windows
setw -g monitor-activity on

# display a status line message when activity occurs
# set -g visual-activity on

# set update frequencey (default 15 seconds)
set -g status-interval 1

# position window on the left
set -g status-justify left

# position the status bar at bottom of screen
set -g status-position bottom

# set color for status bar
set -g status-bg default
set -g status-fg default
set -g status-attr dim

setw -g window-status-format ' #I '
setw -g window-status-current-format ' #I #W '
setw -g window-status-attr default
setw -g window-status-current-attr default

setw -g window-status-activity-attr none
setw -g window-status-activity-fg red
setw -g window-status-activity-bg default

setw -g window-status-current-fg black
setw -g window-status-current-bg yellow

# Left Side
# Session
set -g status-left-length 70
set -g status-left "#[fg=colour237][ #[fg=colour240]#S #[fg=colour237]] "

# Right Side
# https://linux.die.net/man/3/strftime

# set -g @spotify_playing_icon "♫ "
# set -g @spotify_paused_icon "= "
# set -g @spotify_stopped_icon "λ"

set -g status-right-length 120
set -g status-right "#(${DOTFILES}/tmux/status.sh)"

# message
set -g message-bg default
set -g message-fg colour003 # yellow

set -g pane-active-border-fg colour003
