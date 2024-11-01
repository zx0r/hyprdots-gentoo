function ping_host
    while true
        if ping -c 1 "$argv[1]"
            notify-send -i $HOME/.config/swaync/low.png "Server Back Up!" "$argv[1] is online."
            return 0
        else
            sleep 30
        end
    end
end
