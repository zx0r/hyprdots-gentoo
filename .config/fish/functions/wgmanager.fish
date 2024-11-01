# Bring up the WireGuard interface
function wgup
    set iface $argv[1]
    if test -z "$iface"
        echo "Usage: wgup <interface>"
        return 1
    end
    echo "Bringing up WireGuard interface: $iface"
    sudo wg-quick up $iface
end

# Bring down the WireGuard interface
function wgdown
    set iface $argv[1]
    if test -z "$iface"
        echo "Usage: wgdown <interface>"
        return 1
    end
    echo "Bringing down WireGuard interface: $iface"
    sudo wg-quick down $iface
end

# Reload the WireGuard interface configuration
function wgreload
    set iface $argv[1]
    if test -z "$iface"
        echo "Usage: wgreload <interface>"
        return 1
    end
    echo "Reloading WireGuard interface: $iface"
    sudo wg-quick down $iface && sudo wg-quick up $iface
end

# Show the status of all WireGuard interfaces
function wgshow
    set iface $argv[1]

    if test -z "$iface"
        echo "Showing WireGuard interface status:"
        sudo wg show
    else
        echo "Checking WireGuard interface $interface status..."
        sudo wg show $iface
    end
end

function wgenable
    set iface $argv[1]
    if test -z "$iface"
        echo "Usage: wgdown <interface>"
        return 1
    end
    echo "Enabling WireGuard interface $interface at boot (OpenRC)..."
    sudo rc-update add wg-quick.$iface default

end

function wgdisable
    set iface $argv[1]
    if test -z "$iface"
        echo "Usage: wgup <interface>"
        return 1
    end
    echo "Disabling WireGuard interface $interface at boot (OpenRC)..."
    sudo rc-update del wg-quick.$iface default
end

# Add a peer to the WireGuard configuration
function wgadd
    set iface $argv[1]
    set peer_pubkey $argv[2]
    set peer_endpoint $argv[3]
    set peer_allowed_ips $argv[4]

    if test -z "$iface" -o -z "$peer_pubkey" -o -z "$peer_endpoint" -o -z "$peer_allowed_ips"
        echo "Usage: wgaddpeer <interface> <peer_public_key> <peer_endpoint> <peer_allowed_ips>"
        return 1
    end

    echo "Adding peer to WireGuard interface: $iface"
    sudo wg set $iface peer $peer_pubkey endpoint $peer_endpoint allowed-ips $peer_allowed_ips
end

# Remove a peer from the WireGuard configuration
function wgdel
    set iface $argv[1]
    set peer_pubkey $argv[2]

    if test -z "$iface" -o -z "$peer_pubkey"
        echo "Usage: wgdelpeer <interface> <peer_public_key>"
        return 1
    end

    echo "Removing peer from WireGuard interface: $iface"
    sudo wg set $iface peer $peer_pubkey remove
end
