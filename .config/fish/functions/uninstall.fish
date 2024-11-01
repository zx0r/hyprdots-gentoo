function uninstall --description "Remove specified packages from XDG directories (cache, data, state, config). Supports multiple package names."

    # Ensure at least one package is provided
    if test (count $argv) -eq 0
        echo "Usage: uninstall <package_name> [additional_package_names...]"
        return 1
    end

    # XDG directories to remove package data from
    set -l dirs $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME
    # $XDG_CONFIG_HOME

    # Loop through each package
    for package in $argv
        for dir in $dirs
            set -l target "$dir/$package"
            if test -d "$target"
                echo "Removing $target"
                rm -rf "$target"
            end
        end
    end
end

function nvim-profile-del --description "Remove nvim-profile from XDG directories"

    # Ensure at least one package is provided
    if test (count $argv) -eq 0
        echo "Usage: uninstall <nvim-profile> [additional_package_names...]"
        return 1
    end

    set -l dirs $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CONFIG_HOME

    set -l profile $argv[1]
    set -l target_dir "nvim-profiles/$profile"

    for dir in $dirs
        set -l target "$dir/$target_dir"
        if test -d "$target"
            echo "Removing $target"
            rm -rf "$target"
        end
    end
end
abbr -a nvimdel nvim-profile-del
