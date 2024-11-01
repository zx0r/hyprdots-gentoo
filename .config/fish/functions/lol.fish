function lol
    if isatty stdout
        command $argv | lolcat
    else
        command $argv
    end
end

set -l COMMANDS ls cat neofetch find ranger ps ip

for COMMAND in $COMMANDS
    alias $COMMAND "lol $COMMAND"
    alias .$COMMAND (which $COMMAND)
end
