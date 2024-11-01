# If eza is installed, then use eza for some ls commands
if type -q eza
    function l.
        eza -a | egrep "^\."
    end

    function ls
        eza -abhl --git --icons=auto --color=always --group-directories-first # my preferred listing
    end

    function la
        eza -a --color=always --group-directories-first # all files and dirs
    end

    function ll
        eza -aghHlmuSU --icons=auto --color=always --group-directories-first --git --time-style long-iso --octal-permissions # long format
    end

    # function ll
    #     eza -lahHgb --git --icons=auto --color=always --time-style long-iso --octal-permissions
    # end

    function lt
        eza -aT --icons=auto --color=always --group-directories-first -snew # tree listing
    end

    function lx
        eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons=auto
    end

    function t
        eza --tree --color=always --icons=auto
    end

    function t2
        eza --tree --level=2 --color=always --group-directories-first --icons=auto -snew
    end

    function t3
        eza --tree --level=3 --color=always --group-directories-first --icons=auto -snew
    end

    function t4
        eza --tree --level=4 --color=always --group-directories-first --icons=auto -snew
    end

    set -U FZF_PREVIEW_DIR_CMD 'eza --tree --color=always --group-directories-first -s extension -F -L 2'
else
    function la
        ls -A # List all files including hidden
    end

    function ll
        ls -lAFh # List all files with full details
    end

    function lb
        ls -lhSA # List files sorted by size
    end

    function lm
        ls -tA -1 # List files sorted by last modified
    end
end

# If eza is installed, then use eza for some ls commands
# if command -v eza
#     alias l. 'eza -a | egrep "^\."'
#     alias ls 'eza -al --color=always --group-directories-first' # my preferred listing
#     alias la 'eza -a --color=always --group-directories-first' # all files and dirs
#     alias ll 'eza -abghilmu --icons=auto --color=always --group-directories-first' # long format
#     alias lt 'eza -aT --icons=auto --color=always --group-directories-first -snew' # tree listing
#     alias lx 'eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons=auto'
#
#     alias t 'eza --tree --color=always --icons=auto'
#     alias t2 'eza --tree --level=2 --color=always --group-directories-first --icons=auto -snew'
#     alias t3 'eza --tree --level=3 --color=always --group-directories-first --icons=auto -snew'
#     alias t4 'eza --tree --level=4 --color=always --group-directories-first --icons=auto -snew'
#
#     set -U FZF_PREVIEW_DIR_CMD 'eza --tree --color=always --group-directories-first -s extension -F -L 2'
# else
#     alias la 'ls -A' # List all files including hidden
#     alias ll 'ls -lAFh' # List all files with full details
#     alias lb 'ls -lhSA' # List files sorted by size
#     alias lm 'ls -tA -1' # List files sorted by last modified
# end
