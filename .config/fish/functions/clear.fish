function clear
    printf "\x1b[2J\x1b[1;1H"
    seq 1 (tput cols) | sort -R | spark | lolcat
end
