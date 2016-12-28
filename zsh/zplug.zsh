# Sourced by .zshrc

# Themes
# zplug "cusxio/delta-prompt", use:delta.zsh
zplug "${ZDOTDIR}", from:local, use:"{prompt,}.zsh", defer:3
zplug "mafredri/zsh-async"

# ZSH
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-autosuggestions"

# Utilities
zplug "supercrabtree/k"
zplug "plugins/colored-man-pages", from:oh-my-zsh

# Self managing zplug
zplug "zplug/zplug"
