if type -q zoxide
    set --export _ZO_DATA_DIR $XDG_DATA_HOME/zoxide
    zoxide init fish | source
end

if type -q mise
    mise activate fish | source
end

if type -q fzf
    set --export --append FZF_DEFAULT_OPTS "--layout=reverse --info=right --height=~40%"
    set --export --append FZF_DEFAULT_OPTS "--color=gutter:#121212"
    set --export --append FZF_DEFAULT_OPTS "--color=prompt:#1bfd9c,spinner:#1bfd9c,pointer:#1bfd9c"
    set --export --append FZF_DEFAULT_OPTS "--color=hl:#5ffdb9,hl+:#1bfd9c,info:#555555,marker:#87ff00"
    set --export --append FZF_DEFAULT_OPTS "--border=rounded --preview-window=border-rounded --color=border:#444444"
    set --export --append FZF_DEFAULT_OPTS "--color=fg:#444444"
end
