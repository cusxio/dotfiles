# Status line
set -g status-bg default
set -g status-fg default
set -g status-left-length 100
set -g status-left " #[fg=default]cusx#[fg=red] >> #[fg=colour250]%l:%M %p"
set -g status-right-length 0
set -g status-right ""
set -g status-justify right
setw -g window-status-format '#[fg=default]#I|#[fg=default]#W'
setw -g window-status-current-format '#[fg=red]#I|#[fg=red]#W'

# Messages
set -g message-attr underscore
set -g message-fg black
set -g message-bg red

# Panes
set-option -g pane-border-fg colour241
set-option -g pane-active-border-fg red
