if type -q zoxide
    set --export _ZO_DATA_DIR $XDG_DATA_HOME/zoxide
    zoxide init fish | source
end

if type -q mise
    mise activate fish | source
end

# if type -q fzf
#     # set --export --append FZF_DEFAULT_OPTS "--layout=reverse --info=right --height=~40%"
#     # set --export --append FZF_DEFAULT_OPTS "--color=gutter:#121212"
#     # set --export --append FZF_DEFAULT_OPTS "--color=prompt:#1bfd9c,spinner:#1bfd9c,pointer:#1bfd9c"
#     # set --export --append FZF_DEFAULT_OPTS "--color=hl:#5ffdb9,hl+:#1bfd9c,info:#555555,marker:#87ff00"
#     # set --export --append FZF_DEFAULT_OPTS "--border=rounded --preview-window=border-rounded --color=border:#444444"
#     # set --export --append FZF_DEFAULT_OPTS "--color=fg:#aaaaaa"
#
#     set --export --append FZF_DEFAULT_OPTS "--highlight-line \
#       --info=inline-right \
#       --ansi \
#       --layout=reverse \
#       --border=none
#       --color=bg+:#283457 \
#       --color=bg:#16161e \
#       --color=border:#27a1b9 \
#       --color=fg:#c0caf5 \
#       --color=gutter:#16161e \
#       --color=header:#ff9e64 \
#       --color=hl+:#2ac3de \
#       --color=hl:#2ac3de \
#       --color=info:#545c7e \
#       --color=marker:#ff007c \
#       --color=pointer:#ff007c \
#       --color=prompt:#2ac3de \
#       --color=query:#c0caf5:regular \
#       --color=scrollbar:#27a1b9 \
#       --color=separator:#ff9e64 \
#       --color=spinner:#ff007c"
# end
