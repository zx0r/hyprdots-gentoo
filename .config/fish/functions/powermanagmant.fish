# Shutdown the system
function shutdown
    echo "Shutting down the system..."
    sudo shutdown -h now
end

# Reboot the system
function reboot
    echo "Rebooting the system..."
    sudo reboot
end

# Hibernate the system
# function hibernate
#     echo "Hibernating the system..."
#     sudo hibernate-ram # This may require sys-power/hibernate-script to be installed
# end
#
# # Suspend (Sleep) the system
# function sleep
#     echo "Suspending the system..."
#     sudo rtcwake -m mem -s 3600 # Puts system to sleep for 1 hour (modify as needed)
# end
#
# # Logout from the current session
# function logout
#     echo "Logging out from the current session..."
#     pkill -KILL -u $USER
#     #or
#     if status --is-interactive
#         kill -HUP $fish_pid
#     else
#         echo "Unable to logout. This is not an interactive session."
#     end
# end
#
# # Lock the screen
# function lock
#     echo "Locking the screen..."
#     # Assuming you're using a screen locker, replace 'i3lock' with the appropriate command
#     wlogout # Replace with your preferred screen locker (e.g., 'betterlockscreen', 'slock')
# end
#
# # Show system status
# function status
#     echo "Showing system status..."
#     uptime
#     free -h
#     df -h
#     acpi -b # Prints battery status
#     rc-status # Displays the status of all OpenRC services
# end

# function powermanagemant
#     # Detect init system
#     if test -f /run/openrc/softlevel
#         set init_system "openrc"
#     else if test (pidof systemd)
#         set init_system "systemd"
#     else if test -f /sbin/init -a -x /etc/init.d
#         set init_system "sysvinit"
#     else
#         echo "Unsupported init system or could not detect init system."
#         return 1
#     end
#
#     # Display init system
#     echo "Detected init system: $init_system"
#
#     # Check if action is provided
#     set action $argv[1]
#     if test -z "$action"
#         echo "Usage: system_manager <action>"
#         echo "Available actions: shutdown, reboot, hibernate, sleep, logout, lock, status"
#         return 1
#     end
#
#     # Select the command based on init system and action
#     switch $action
#         case "shutdown"
#             switch $init_system
#                 case "openrc"
#                     sudo shutdown -h now
#                 case "systemd"
#                     sudo systemctl poweroff
#                 case "sysvinit"
#                     sudo init 0
#             end
#         case "reboot"
#             switch $init_system
#                 case "openrc"
#                     sudo reboot
#                 case "systemd"
#                     sudo systemctl reboot
#                 case "sysvinit"
#                     sudo init 6
#             end
#         case "hibernate"
#             switch $init_system
#                 case "openrc"
#                     sudo hibernate-ram
#                 case "systemd"
#                     sudo systemctl hibernate
#                 case "sysvinit"
#                     echo "Hibernation is not available by default on SysVinit"
#             end
#         case "sleep"
#             switch $init_system
#                 case "openrc"
#                     sudo zzz
#                 case "systemd"
#                     sudo systemctl suspend
#                 case "sysvinit"
#                     echo "Sleep is not available by default on SysVinit"
#             end
#         case "logout"
#             switch $init_system
#                 case "openrc" -or "systemd"
#                     gnome-session-quit --logout --no-prompt
#                 case "sysvinit"
#                     echo "Logout is not available by default on SysVinit"
#             end
#         case "lock"
#             switch $init_system
#                 case "*"
#                     gnome-screensaver-command -l
#             end
#         case "status"
#             switch $init_system
#                 case "openrc"
#                     rc-status
#                 case "systemd"
#                     sudo systemctl status
#                 case "sysvinit"
#                     service --status-all
#             end
#         case "*"
#             echo "Invalid action. Available actions: shutdown, reboot, hibernate, sleep, logout, lock, status"
#             return 1
#     end
# end
#
