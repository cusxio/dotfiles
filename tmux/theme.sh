# ----------------------
# Status Bar
# -----------------------

# turn the status bar on
set-option -g status on

# visual notification of activity in other windows
setw -g monitor-activity on
set -g visual-activity on

# set update frequencey (default 15 seconds)
set -g status-interval 1

# position window on the left
set -g status-justify left

# position the status bar at bottom of screen
set-option -g status-position bottom

# set color for status bar
set-option -g status-bg default
set-option -g status-fg default
set-option -g status-attr dim

set-window-option -g window-status-format ' #I '
set-window-option -g window-status-current-format ' #I #W '
set-window-option -g window-status-attr default
set-window-option -g window-status-current-attr default

set-window-option -g window-status-activity-fg red
set-window-option -g window-status-activity-bg black

set-window-option -g window-status-current-fg black
set-window-option -g window-status-current-bg yellow

# Left Side
# Session
set -g status-left-length 70
set -g status-left "#[fg=colour237][ #[fg=colour240]#S #[fg=colour237]] "

# Right Side
set -g status-right-length 120
set -g status-right "#[fg=colour237][ #[fg=yellow]#(echo $(node -v)) #[fg=colour237]]#[fg=colour237][ #[fg=colour240]%A, %d %b %H:%M #[fg=colour237]]"

# message
set-option -g message-bg default
set-option -g message-fg colour003 # yellow

set-option -g pane-active-border-fg colour003
