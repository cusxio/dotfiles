if type -q eza
    function ll
        command eza -lagh -F --git --icons --group-directories-first $argv
    end
end
