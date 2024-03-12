if not status is-interactive
    exit
end


if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\ct --git_log=\cl --processes=\cp
    if type -q eza
        set fzf_preview_dir_cmd eza --all --color=always
    end

    if type -q delta
        set fzf_diff_highlighter delta
    end
end
