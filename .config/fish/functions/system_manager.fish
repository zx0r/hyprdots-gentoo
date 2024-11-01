function ms
    # Detect init system
    if test -f /run/openrc/softlevel
        set init_system openrc
    else if test (pidof systemd)
        set init_system systemd
    else if test -d /etc/runit/sv
        set init_system runit
    else
        echo "Unsupported init system or could not detect init system."
        return 1
    end

    # Display init system
    echo "Detected init system: $init_system"

    # Check if action is provided
    set action $argv[1]
    set service_name $argv[2]
    if test -z "$action"
        echo "Usage: manage_services <action> [service_name]"
        echo "Available actions: list, start, stop, restart, status, enable, disable, failed"
        return 1
    end

    # Init system command logic
    switch $action
        case list
            switch $init_system
                case systemd
                    systemctl list-unit-files
                case openrc
                    rc-update -v show
                case runit
                    ls /etc/sv
            end
        case list-running
            switch $init_system
                case systemd
                    systemctl list-units
                case openrc
                    rc-status
                case runit
                    sv status /var/service/*
            end
        case failed
            switch $init_system
                case systemd
                    systemctl --failed
                case openrc
                    rc-status --crashed
                case runit
                    echo "Runit doesn't have built-in failed service detection."
            end
        case start
            if test -z "$service_name"
                echo "Please provide a service name."
                return 1
            end
            switch $init_system
                case systemd
                    sudo systemctl start $service_name
                case openrc
                    sudo rc-service $service_name start
                case runit
                    sudo sv up $service_name
            end
        case stop
            if test -z "$service_name"
                echo "Please provide a service name."
                return 1
            end
            switch $init_system
                case systemd
                    sudo systemctl stop $service_name
                case openrc
                    sudo rc-service $service_name stop
                case runit
                    sudo sv down $service_name
            end
        case restart
            if test -z "$service_name"
                echo "Please provide a service name."
                return 1
            end
            switch $init_system
                case systemd
                    sudo systemctl restart $service_name
                case openrc
                    sudo rc-service $service_name restart
                case runit
                    sudo sv restart $service_name
            end
        case status
            if test -z "$service_name"
                echo "Please provide a service name."
                return 1
            end
            switch $init_system
                case systemd
                    systemctl status $service_name
                case openrc
                    rc-service $service_name status
                case runit
                    sv status $service_name
            end
        case enable
            if test -z "$service_name"
                echo "Please provide a service name."
                return 1
            end
            switch $init_system
                case systemd
                    sudo systemctl enable $service_name
                case openrc
                    sudo rc-update add $service_name
                case runit
                    sudo ln -s /etc/sv/$service_name /var/service
            end
        case disable
            if test -z "$service_name"
                echo "Please provide a service name."
                return 1
            end
            switch $init_system
                case systemd
                    sudo systemctl disable $service_name
                case openrc
                    sudo rc-update del $service_name
                case runit
                    sudo rm /var/service/$service_name
            end
        case "*"
            echo "Invalid action. Available actions: list, list-running, failed, start, stop, restart, status, enable, disable"
            return 1
    end
end
