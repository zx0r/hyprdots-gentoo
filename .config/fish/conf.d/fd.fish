if type -q fd
    set -U FZF_CD_COMMAND "fd -t d" # Command to find directories
    set -U FZF_OPEN_COMMAND "fd -H -t f" # Command to find files, including hidden
    set -U FZF_FIND_FILE_COMMAND "fd -t f" # Command to find files
    set -U FZF_CD_WITH_HIDDEN_COMMAND "fd -H -t d" # Command to find hidden directories
end
