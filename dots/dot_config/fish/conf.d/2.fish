# if type -q eza
#     function ll
#         command eza -lagh -F --git --icons --group-directories-first $argv
#     end
# end

if type -q lsd
    alias ls='lsd'
    alias l='ls -l'
    alias la='ls -a'
    alias lla='ls -la'
    alias lt='ls --tree'
end
