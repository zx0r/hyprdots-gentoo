function myip
    set ip (curl -s "https://icanhazip.com/")
    if test -z "$ip"
        set ip (dig @resolver1.opendns.com ANY myip.opendns.com +short)
    end
    echo $ip
end
