# Make directory and cd into it
function mkd
    set dir $argv
    mkdir -p "$dir"; and cd "$dir"
end

# Make directory and copy files into it
function mkcp
    set dir $argv[2]
    set tmp $argv[2]
    set tmp (string sub -1 $tmp)
    if test "$tmp" != /
        set dir (dirname "$argv[2]")
    end
    if not test -d "$dir"
        mkdir -p "$dir"; and cp -r $argv
    end
end

# Move directory and move into it
function mkmv
    set dir $argv[2]
    set tmp $argv[2]
    set tmp (string sub -1 $tmp)
    if test "$tmp" != /
        set dir (dirname "$argv[2]")
    end
    if not test -d "$dir"
        mkdir -p "$dir"; and mv $argv
    end
end
