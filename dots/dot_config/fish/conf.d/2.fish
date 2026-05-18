if type -q lsd
    set -l lsd_opts --group-dirs first

    abbr --add ls "lsd $lsd_opts"
    abbr --add l "lsd $lsd_opts -l"
    abbr --add la "lsd $lsd_opts -a"
    abbr --add lla "lsd $lsd_opts -la"
    abbr --add lt "lsd $lsd_opts --tree"
end

if type -q claude
    abbr --add claude claude --dangerously-skip-permissions
end
