if type -q lsd
    alias ls='lsd'
    alias l='ls -l'
    alias la='ls -a'
    alias lla='ls -la'
    alias lt='ls --tree'
end

if type -q claude
    abbr --add claude claude --dangerously-skip-permissions
end
