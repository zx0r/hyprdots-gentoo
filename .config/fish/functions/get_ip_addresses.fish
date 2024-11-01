function get_ip_addresses
    set -l ip0 (ip -4 addr | grep -v 127.0.0.1 | grep -v secondary | grep ppp0 | string match -r 'inet (\S+)' | head -n1 | cut -d' ' -f2)
    set -l ip1 (ip -4 addr | grep -v 127.0.0.1 | grep -v secondary | grep eth0 | string match -r 'inet (\S+)' | head -n1 | cut -d' ' -f2)
    set -l ip2 (ip -4 addr | grep -v 127.0.0.1 | grep -v secondary | grep tun0 | string match -r 'inet (\S+)' | head -n1 | cut -d' ' -f2)
    set -l ip3 (ip -4 addr | grep -v 127.0.0.1 | grep -v secondary | grep wlan0 | string match -r 'inet (\S+)' | head -n1 | cut -d' ' -f2)

    set -l ips
    for ip in $ip0 $ip1 $ip2 $ip3
        if test -n "$ip"
            set -a ips $ip
        end
    end

    if test (count $ips) -gt 0
        printf "(%s)" (string join ", " $ips)
    end
end
