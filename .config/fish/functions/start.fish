function start
    wgup wg1 && wgshow && clear && ping -qc1 google.com && check_ip | lolcat && printf "Success connected ..." || printf "Not connected..."
end
