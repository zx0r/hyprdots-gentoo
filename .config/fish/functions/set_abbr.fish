function set_abbr
    if test (count $argv) -lt 2
        echo "Usage: abbr -a <abbreviation> <command>"
        return 1
    end
    set abbr_name $argv[1]
    set command $argv[2]

    # Check if the abbreviation is already used
    if not contains $abbr_name (abbr --show)
        abbr -a $abbr_name $command
    end
end
