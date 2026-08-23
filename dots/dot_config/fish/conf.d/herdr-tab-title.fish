# Remove the handlers from the previous pane-title version when re-sourcing.
functions --erase __herdr_set_process_title __herdr_clear_process_title \
    __herdr_report_process_metadata 2>/dev/null

if status is-interactive; and test "$HERDR_ENV" = 1; and set --query HERDR_TAB_ID
    function __herdr_command_name --argument-names commandline
        printf '%s\n' "$commandline" | read --tokenize --list tokens
        set --local index 1

        # Skip environment assignments and fish command prefixes.
        while test $index -le (count $tokens)
            if string match --quiet --regex '^[A-Za-z_][A-Za-z0-9_]*=' -- "$tokens[$index]"
                set index (math $index + 1)
                continue
            end

            if contains -- "$tokens[$index]" command builtin exec not time
                set index (math $index + 1)
                continue
            end

            break
        end

        if test $index -le (count $tokens)
            path basename -- "$tokens[$index]"
        end
    end

    function __herdr_cli
        set --local herdr_bin herdr
        if set --query HERDR_BIN_PATH
            set herdr_bin "$HERDR_BIN_PATH"
        else if not type --query herdr
            return 127
        end

        command "$herdr_bin" $argv
    end

    function __herdr_set_process_tab_title --on-event fish_preexec
        set --local title (__herdr_command_name "$argv[1]")
        test -n "$title"; or return

        set --erase --global __herdr_previous_tab_title
        if type --query jq
            set --global __herdr_previous_tab_title \
                (__herdr_cli tab get "$HERDR_TAB_ID" 2>/dev/null | command jq --raw-output --exit-status '.result.tab.label')
        end

        __herdr_cli tab rename "$HERDR_TAB_ID" "$title" >/dev/null 2>/dev/null
    end

    function __herdr_restore_tab_title --on-event fish_postexec
        if set --query __herdr_previous_tab_title
            __herdr_cli tab rename "$HERDR_TAB_ID" "$__herdr_previous_tab_title" >/dev/null 2>/dev/null
            set --erase --global __herdr_previous_tab_title
        end
    end
end
