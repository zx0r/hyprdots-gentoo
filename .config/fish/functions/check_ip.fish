function check_ip
    set -l pubip (curl -s http://ifconfig.me/ip)
    set -l request (curl -s "http://ip-api.com/json/$pubip")
    set -l ip (echo "$request" | jq -r '.query')
    set -l city (echo "$request" | jq -r '.city')
    set -l country (echo "$request" | jq -r '.country')
    set -l isp (echo "$request" | jq -r '.isp')
    printf "%sIP: %s%s %sCity: %s%s %sCountry: %s%s %sISP: %s%s\n" \
        "$BPurple" "$ip" "$NoColor" \
        "$BGreen" "$city" "$NoColor" \
        "$BBlue" "$country" "$NoColor" \
        "$BRed" "$isp" "$NoColor"
end
