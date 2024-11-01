function setup_npm_global
    set -l npm_global_dir "$HOME/.npm-global"

    # Create the directory if it doesn't exist
    if not test -d $npm_global_dir
        mkdir -p $npm_global_dir
    end

    # Set npm prefix to the global directory
    npm config set prefix $npm_global_dir

    # Add the bin directory to PATH if it's not already there
    set -gx node_path "$npm_global_dir/bin"
    if not contains $node_path $PATH
        fish_add_path $node_path
    end
    source $HOME/.config/fish/config.fish

    # Print success message
    echo "npm global directory set to $npm_global_dir"
    echo "Added $node_path to PATH"
    echo "Please restart your shell or run 'source ~/.config/fish/config.fish' to apply changes"
end
