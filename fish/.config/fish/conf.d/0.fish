# set --erase PATH

if type -q /usr/local/bin/brew
    eval (/usr/local/bin/brew shellenv)
end

set --global fish_greeting

set --query XDG_CONFIG_HOME || set --export XDG_CONFIG_HOME $HOME/.config
set --query XDG_CACHE_HOME || set --export XDG_CACHE_HOME $HOME/.cache
set --query XDG_DATA_HOME || set --export XDG_DATA_HOME $HOME/.local/share

set --export MANPAGER "sh -c 'col -bx | bat -l man -p'"

set --export SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

if type -q nvim
    set --export EDITOR nvim
end

abbr --add c clear
abbr --add gst git status

abbr --add gl git log

abbr --add gcam git commit --amend -m
abbr --add gcm git commit -m

abbr --add gco git checkout
abbr --add gcob git checkout -b
abbr --add gd git diff
abbr --add gdup git diff @{upstream}
abbr --add gp git push
