if not status is-interactive
    exit
end

if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\ct --git_log=\cl --git_status=\cs --processes=\cp
    if type -q eza
        set fzf_preview_dir_cmd eza --all --color=always
    end

    if type -q delta
        set fzf_diff_highlighter delta
    end
end

if type -q git-forgit
    # https://github.com/PatrickF1/fzf.fish/blob/8920367cf85eee5218cc25a11e209d46e2591e7a/functions/_fzf_wrapper.fish
    set --export FORGIT_FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"'
    # Just changing the relative date brighter
    # https://github.com/wfxr/forgit/blob/5d4d6121b1c92b4890abdb90fc232db67e08b10d/bin/git-forgit#L218
    set --export FORGIT_LOG_FORMAT '%C(auto)%h%d %s %C(8)%cr%Creset'
end
