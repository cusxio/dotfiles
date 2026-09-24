if status is-interactive; and type -q mise
    mise activate fish | source
end

if type -q zoxide
    set --export _ZO_DATA_DIR $XDG_DATA_HOME/zoxide
    zoxide init fish | source
end
