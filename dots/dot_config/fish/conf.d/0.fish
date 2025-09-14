if type -q /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin
end

if test -d $HOME/.lmstudio/bin
    fish_add_path $HOME/.lmstudio/bin
end

if test -d $FORGIT_INSTALL_DIR/bin
    fish_add_path $FORGIT_INSTALL_DIR/bin
end

set --global fish_greeting

set --query XDG_CONFIG_HOME || set --export XDG_CONFIG_HOME $HOME/.config
set --query XDG_CACHE_HOME || set --export XDG_CACHE_HOME $HOME/.cache
set --query XDG_DATA_HOME || set --export XDG_DATA_HOME $HOME/.local/share

set --export MOON_HOME $XDG_DATA_HOME/moon

set --export BUN_INSTALL_CACHE_DIR $XDG_CACHE_HOME/bun

set --export MANPAGER "sh -c 'col -bx | bat -l man -p'"

set --export PNPM_HOME $XDG_DATA_HOME/pnpm
fish_add_path $PNPM_HOME

if type -q rg
 set --export RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/config
end

if type -q nvim
    set --export EDITOR nvim
    set --export NVIM_APPNAME lazyvim
    abbr --add astro "env NVIM_APPNAME=astronvim nvim"
    abbr --add nvchad "env NVIM_APPNAME=nvchad nvim"
end

abbr --add c clear
abbr --add gst git status

abbr --add gl git log

abbr --add gc git clone

abbr --add --set-cursor='%' gcam 'git commit --amend -m "%"'
abbr --add --set-cursor='%' gcm 'git commit -m "%"'
abbr --add gcane git commit --amend --no-edit

abbr --add gco git checkout
abbr --add gcob git checkout -b
abbr --add gd git diff
abbr --add gdup git diff @{upstream}
abbr --add gp git push

abbr --add gb git branch

alias ...="cd ../.."
alias ....="cd ../../.."

if test -d $HOME/Library/Android/sdk
    set --export ANDROID_HOME $HOME/Library/Android/sdk
    fish_add_path $ANDROID_HOME/emulator
    fish_add_path $ANDROID_HOME/platform-tools
end

if test -d $GHOSTTY_RESOURCES_DIR
    source $GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
end

# Needs to be initialize before fisher initialize it
set --export FORGIT_NO_ALIASES 1
