if type -q eza
    function ll
        command eza -Flagh --git --icons --group-directories-first $argv
    end
end
