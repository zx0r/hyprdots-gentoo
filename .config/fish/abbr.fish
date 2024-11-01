#http://bradleymacomber.com/ref/Gentoo/#
# ~/.config/fish/functions/gentoo_cheat_sheet.fish
# This file contains Fish shell abbreviations for common Gentoo commands
# Abbreviations allow quicker execution of common system management tasks

# --- Portage Commands ---
abbr -a sync "sudo eix-sync -a"
abbr -a edp "sudo eclean -qC packages; sudo eclean -qdC -t1w distfiles"
abbr -a eip 'qlist -IRv'
abbr -a epw 'eix --color -c --world | less -R' # Set abbreviationsA

# --- Emerge Commands ---
abbr -a ei "sudo emerge -av" # Install a package
abbr -a er "sudo emerge --unmerge" # Remove a package
abbr -a eiu "sudo emerge -avuDN @world" # Update and upgrade packages
abbr -a econf "sudo etc-update" # Handle configuration file updates
abbr -a dp "sudo dispatch-conf"

# --- Package Management Helpers ---
abbr -a euse "euse -i" # Inspect USE flags
abbr -a equery "equery u {pkg}"
abbr -a elog "sudo genlop -l" # View emerge logs
abbr -a epl "sudo emerge --pretend --verbose" # Pretend to install with details

# --- Kernel and System Management ---:wq
abbr -a modreb "sudo emerge @module-rebuild" # Rebuild kernel modules after kernel update
abbr -a modrebnew "sudo emerge @preserved-rebuild"
abbr -a esaveconfig "sudo cp /usr/src/linux/.config ~/kernel-config-$(uname -r)" # Backup current kernel config
abbr -a ekernelbuild "sudo make -j$(nproc) && sudo make modules_install && sudo make install" # Build and install a new kernel
abbr -a cdkern "cd /usr/src/linux && sudo make menuconfig"

abbr -a esync "sudo emaint sync -a" # Sync Portage tree and all overlays
abbr -a reposync 'sudo emaint sync -r {repo}'
abbr -a repolist 'eselect repository list'
abbr -a reposhow 'eselect repository list -i'
abbr -a repoadd 'sudo eselect repository enable {repo1} {repo2} {repo3}'
abbr -a repodisable 'eselect repository disable {repo1} {repo2}'
abbr -a repodel 'eselect repository remove {repo1} {repo2}'
abbr -a repocreate 'eselect repository create <ebuild_repository_name>'
abbr -a repoaddgit 'eselect repository add test git https://github.com/test/test.git'
abbr -a reposyncgit 'emerge --ask dev-vcs/git'

#Upgrade the selected packages, dependencies and deep dependencies that are outdated or have USE flag changes
#emerge -uDN world
abbr -a eunu "sudo emerge --ask --verbose --update --newuse --deep @world" # Full system update
abbr -a eucu "sudo emerge --ask --verbose --update --changed-use --deep @world" # Rebuild with USE changes
abbr -a eixuwb "sudo emerge -pv -uDN --with-bdeps=y @world" #--changed-use  List what packages would be installed without installing them
abbr -a upcert "sudo emerge --oneshot app-misc/ca-certificates && sudo update-ca-certificates"
abbr -a depclean "sudo emerge --depclean" # Remove unused packages
abbr -a unm 'emerge --deselect {package} && emerge --pretend --depclean && emerge --ask --depclean'

#Remove a package and the dependencies that no other packages depend on
abbr -a erem "sudo emerge -cav {package}"
#Remove a package but not its dependencies
abbr -a eremc "sudo emerge -C {package}"
#Remove unneeded dependencies
abbr -a eremdep "sudo emerge -ca (--depclean --ask) {package}"

# abbr -a a alias
abbr -a c clear
# abbr -a d docker
# abbr -a f fd
# abbr -a g git
# abbr -a h history
abbr -a i 'clear && check_ip | lolcat'
# abbr -a j jobs
abbr -a l 'clear && ll'
# abbr -a m man
abbr -a n nvim
# abbr -a p pwd
# abbr -a r ranger
abbr -a ra ranger
# abbr -a s sudo
# abbr -a v nvim
#abbr -a vi nvim
abbr -a y yazi
# abbr -a q exit

#ln -sf $HOME/.local/share/AppImage/squashfs-root/AppRun ~/.local/bin/zenbrowser
abbr -a b zenbrowser
#
# abbr -a B $XDG_BIN_DIR
# abbr -a S $XDG_DATA_HOME
# abbr -a C $XDG_CONFIG_HOME
# abbr -a D $XDG_DOTFILES_DIR
#
# Command line head / tail shortcuts
abbr -g H '| head {value}' # Pipes output to head (the first part of a file)
abbr -g T '| tail {value}' # Pipes output to tail (the last part of a file)
abbr -g G '| grep {value}' # Pipes output to grep to search for some word
abbr -g L '| less {value}' # Pipes output to less, useful for paging
abbr -g M '| most {value}' # Pipes output to more, useful for paging
abbr -g LL '2>&1 | less' # Writes stderr to stdout and passes it to less
abbr -g CA '2>&1 | cat -A' # Writes stderr to stdout and passes it to cat
abbr -g NE '2> /dev/null' # Silences stderr
abbr -g NUL '> /dev/null 2>&1' # Silences both stdout and stderr
abbr -g P '2>&1 | pygmentize -l pytb' # Writes stderr to stdout and passes to pygmentize

# File Permission 
abbr -a 000 'chmod -R 000' # # .---------  No permissions for owner, group, or others
abbr -a 500 'chmod -R 500' # # r-x------   Avoid Changing
abbr -a 600 'chmod -R 600' # # rw-------   Changeable by user: Read and write for owner only
abbr -a 644 'chmod -R 644' # # rw-r--r--   Read and change by user: Read and write for owner, read for group and others
abbr -a 660 'chmod -R 660' # # rw-rw----   Changeable by user and group: Read and write for owner and group
abbr -a 700 'chmod -R 700' # # rwx------   Only user has full access: Read, write, and execute for owner only
abbr -a 755 'chmod -R 755' # # rwxr-xr-x   Only changeable by user: Read, write, and execute for owner; read and execute for group and others
abbr -a 777 'chmod -R 777' # # rwxrwxrwx   Everybody can do everything: Read, write, and execute for everyone

abbr -a chmod- 'chmod -x'
abbr -a chmod+ 'chmod ug+x'
abbr -a chownu "sudo chown -R $(id -u):$(id -g)"

# Quick navigation and action with fzf using fd
abbr -a fcd 'cd (fd --type d | fzf)'
abbr -a fcp 'cp (fd --type f | fzf) destination_dir' # Copy a file using fzf
abbr -a fedit 'nvim (fd --type f | fzf)' # Edit a file in the current directory
abbr -a fless 'less (fd --type f | fzf)' # Open a file with less after fuzzy search
abbr -a fgrep 'rg --smart-case (fd --type f | fzf)' # Search for a string in files
abbr -a fdel 'rm -rfiv (fd --type d | fzf)' # Delete a directory selected with fzf


# Moving around
abbr -a - 'cd -'
abbr -a .. 'cd ..'
abbr -a ... 'cd ../../'
abbr -a .... 'cd ../../../'
abbr -a ..... 'cd ../../../../'

abbr -a cdl "cd $XDG_BIN_HOME"
abbr -a cdls "cd $XDG_DATA_HOME"
abbr -a cfg "cd $XDG_CONFIG_HOME"
abbr -a cdxa "cd $XDG_CACHE_HOME"
abbr -a cdxs "cd $XDG_STATE_HOME"

abbr -a cdb "cd $XDG_BACKUP_DIR"
abbr -a cdc "cd $XDG_DOTFILES_DIR"
abbr -a cdp "cd $XDG_PROJECTS_DIR"

abbr -a cdm "cd $XDG_CONFIG_HOME/mako"
abbr -a cdt "cd $XDG_CONFIG_HOME/tmux"
abbr -a cdh "cd $XDG_CONFIG_HOME/hypr"
abbr -a cdf "cd $XDG_CONFIG_HOME/fish"
abbr -a cdff "cd $XDG_CONFIG_HOME/fish/functions"
abbr -a cdn "cd $XDG_CONFIG_HOME/nvim"
abbr -a cds "cd $XDG_CONFIG_HOME/nvim-profiles"

abbr -a en "nvim $XDG_CONFIG_HOME/nvim/init.lua"
#abbr -a eg "nvim $HOME/.gitconfig"
abbr -a em "nvim $XDG_CONFIG_HOME/mako/config"
abbr -a et "nvim $XDG_CONFIG_HOME/tmux/tmux.conf"
abbr -a ea "nvim $XDG_CONFIG_HOME/fish/abbr.fish"
abbr -a ef "nvim $XDG_CONFIG_HOME/fish/config.fish"

abbr -a sa "source $HOME/.config/fish/abbr.fish"
abbr -a sf "source $HOME/.config/fish/config.fish"
abbr -a st "tmux source-file $HOME/.config/tmux/tmux.conf"

# UNIX
abbr -a ln 'ln -sf'
abbr -a mv "mv -vin"
abbr -a cp "cp -rivap"
abbr -a mkdir "mkdir -pv"
abbr -a mkdirm 'mkdir -p work/{project1,project2}/{src,bin,bak}'
abbr -a rm 'rm -vrfi'
abbr -a um unmount

# Misc
abbr -a ch 'cht.sh'
abbr -a chs 'cht.sh --shell'
abbr -a color 'colortest -w -s'
abbr -a neo neofetch
abbr -a one onefetch
abbr -a matrix 'cmatrix -basfr -u2'
abbr -a vol "wpctl set-volume '@DEFAULT_AUDIO_SINK@'"

# https://fishshell.com/docs/current/commands.html#fish_update_completions
abbr -a ucl fish_update_completions

#System Monitoring
abbr -a meminfo 'free -m -l -t' # Show free and used memory
abbr -a psgrep 'ps aux | grep -v grep | grep -i -e VSZ -e {argv}' # Custom ps grep command
abbr -a memhog 'ps -eo pid,ppid,cmd,%mem --sort=-%mem | head' # Processes consuming most memory
abbr -a cpuhog 'ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head' # Processes consuming most CPU
abbr -a cpuinfo lscpu # Show CPU Info
abbr -a cpu "cpuid -i | grep uarch | head -n 1"
abbr -a distro 'cat /etc/*-release' # Show OS info
abbr -a ports 'netstat -tulanp' # Show open ports

# Copy / pasting
abbr -a cpwd 'pwd | wl-copy' # Copy current path
abbr -a pa wl-paste # Paste clipboard contents

# lsblk
abbr -a lsblk "lsblk --output=NAME,FSTYPE,FSVER,MOUNTPOINT,LABEL,PARTLABEL,UUID,PARTUUID,FSAVAIL,FSUSE%"
abbr -a dmesg 'dmesg -wH || dmesg | less'

# df, du
abbr -a df "df -h"
abbr -a du "du -ht"
abbr -a dum "du --max-depth=1"
abbr -a dus "du --summarize"
abbr -a dfb "df | egrep '/dev/(sd|nvm)'"
abbr -a dud 'du -d 1 -h' # List sizes of files within directory
abbr -a dush 'du -sh *' # List total size of current directory

# Command line history
#abbr -a h-search 'fc -El 0 | grep' # Searches for a word in terminal history
abbr -a top-history 'history 0 | awk "{print $2}" | sort | uniq -c | sort -n -r | head' # Shows top commands
abbr -a histrg 'history -500 | rg {url}' # Ripgrep search recent history

# Network diagnostic commands
abbr -a dig 'dig {domain}' # Get DNS information for a domain
abbr -a mtr 'mtr {host}' # Advanced version of traceroute
abbr -a ping 'ping -c 4 {host}' # Ping remote host N times
abbr -a trace 'traceroute {host}' # Trace route to remote host
abbr -a route 'route -n' # View routing table
abbr -a whois 'whois {domain}' # Obtain WHOIS information for a domain
abbr -a netstat 'netstat -alntup' # Show all listening sockets and process info
abbr -a dnsquery 'host {domain}' # DNS query; use -a for detailed information

# File download commands
abbr -a curl 'curl -fOsSL {url}'
abbr -a curls 'curl -fOsSL --output-dir <some/dir/> {url}'
abbr -a curld 'curl -fsSL --output-dir <some/dir/filename> {url}'

abbr -a wget 'wget -O {url}'
#abbr -a wget 'wget {url}' # Download a file; add --no-check-certificate to ignore SSL verification
abbr -a wget_output 'wget -qO- {url}' # Download a file and output to standard output (not saved)
abbr -a wgetd 'wget -P <some/dir/filename> {url}'

# sort file # 排序文件
abbr -a sort 'sort -u filename{1,2,3} > uniq.txt'

# Show all network addresses (similar to `ip address`)
abbr -a ipshow 'ip a show {iface}' # Display IP address of the eth1 interface
abbr -a iproute 'ip route' # Display the routing table
abbr -a ifconf 'ifconfig {iface}' # Display information for the eth0 interface
abbr -a ifup 'ifconfig {ifce} up' # Activate the eth0 network interface
abbr -a ifdown 'ifconfig {iface} down' # Deactivate the eth0 network interface

# SSH and file transfer commands
abbr -a ssh "set -gx TERM xterm-256color command ssh"
abbr -a mosh "set -gx TERM xterm-256color command mosh"
abbr -a sshrev 'ssh -CqTnN -R 0.0.0.0:8443:192.168.1.2:443 user@202.115.8.1' # # Reverse Proxy: Forward port (8443) from external host (202.115.8.1) to internal host (192.168.1.2:443)
abbr -a sshfwd 'ssh -CqTnN -L 0.0.0.0:8443:192.168.1.2:443 user@192.168.1.3' # # Forward Proxy: Forward local port (8443) through 192.168.1.3 to internal host (192.168.1.2:443)
abbr -a sshsocks 'ssh -CqTnN -D localhost:1080 user@202.115.8.1' # # SOCKS5 Proxy: Forward SOCKS5 proxy requests from local port (1080) through remote host
abbr -a sshfs 'sshfs name@server:/path/to/folder /path/to/mount/point' # Mount a remote filesystem over SSH
abbr -a sshwrt 'ssh root@openwrt.lan' # Login to remote host as user
abbr -a sshport 'ssh -p {port} user@host' # Login to host specifying port
abbr -a sshcopy 'ssh-copy-id user@host' # Copy SSH key to remote host to avoid password prompts
abbr -a scp_push 'scp {fn} user@host:path' # Copy file to remote host
abbr -a scp_pull 'scp user@host:path dest' # Copy file from remote host
abbr -a scp_port 'scp -P {port} ...' # Copy file to remote host specifying port

# Abbreviation to list IP addresses for interfaces matching 'enp'
alias ips "ip a | rg enp | rg inet | sed 's,/24.*noprefixroute,,' | awk '{ print $3"" $2}'"

# File listing options
abbr -a lsr 'ls -R' # List files in sub-directories recursively
abbr -a lsa 'ls -A | grep' # Use grep to find files
abbr -a lsf 'fd . -type f | wc -l' # Shows number of files
abbr -a lss 'ls -l | grep "^d"' # List directories only


# TMUX
abbr -a ta "tmux attach -t"
abbr -a td "tmux attach -td"
abbr -a tn "tmux new-session -sd DEV"
abbr -a ts "tmux switch-client -t"
abbr -a tl 'tmux list-sessions'
abbr -a tkw 'tmux kill-window -t'
abbr -a tksv 'tmux kill-server'
abbr -a tkss 'tmux kill-session -t'
abbr -a tkall 'tmux ls | awk -F: '\''{print $1}'\'' | xargs -r tmux kill-session -t'

# Tmux helpers
# abbr -a tr 'tmux resize-pane'
# abbr -a trh 'tmux resize-pane -R'
# abbr -a trv 'tmux resize-pane -U'
# abbr -a tru 'tmux resize-pane -U'
# abbr -a trd 'tmux resize-pane -D'
# abbr -a trl 'tmux resize-pane -L'
# abbr -a trr 'tmux resize-pane -R'
# abbr -a tsv 'tmux split-window -v'
# abbr -a tsh 'tmux split-window -h'

# # # Tmuxinator
# abbr -a mux tmuxinator
# abbr -a mst 'tmuxinator start'
# abbr -a msa 'tmuxinator start mac-bootstrap'
# abbr -a msb 'tmuxinator start bible_first_online'
# abbr -a msc 'tmuxinator start bf_curriculum'
# abbr -a msd 'tmuxinator start dot'
# abbr -a msl 'tmuxinator start laptop'
# abbr -a msm 'tmuxinator start mux'
# abbr -a msn 'tmuxinator start obsidian'
# abbr -a mso 'tmuxinator start ofreport'
