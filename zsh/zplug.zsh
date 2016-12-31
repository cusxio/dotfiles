# Sourced by .zshrc

# Themes
zplug "mafredri/zsh-async", defer:0
zplug "${ZDOTDIR}", from:local, use:"{prompt,}.zsh", as:theme

# ZSH
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"

# Utilities
zplug "supercrabtree/k"
zplug "plugins/colored-man-pages", from:oh-my-zsh

# Self managing zplug
zplug "zplug/zplug"