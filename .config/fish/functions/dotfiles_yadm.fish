function dotfiles
    # Create the backup directory if it doesn't exist
    set -l backup_dir "$HOME/dotfiles"
    mkdir -p $backup_dir/config

    # List of dotfiles and directories to back up
    set -l files_to_backup zsh-syntax-highlighting/ zsh-git-prompt/ zsh-autosuggestions/ powerlevel10k/ .config/ .zsh_history .fonts.conf

    # Copy each file/directory to the backup location
    for file in $files_to_backup
        if test -e "$HOME/$file" # Check if the file or directory exists
            yes | cp -r "$HOME/$file" "$backup_dir/$file"
        else
            echo "Warning: $file does not exist and will be skipped."
        end
    end

    # If you still want to run the commented part, uncomment it and ensure the logic is correct
    # for i in zsh-syntax-highlighting/ zsh-git-prompt/ zsh-autosuggestions/ powerlevel10k/
    #     set -l testy_dir "$backup_dir/testy$i"
    #     mkdir -p $testy_dir
    #     mv "$backup_dir/$i" "$testy_dir"
    # end

    # Move the .config directory to the backup config directory
    if test -d "$backup_dir/.config/"
        yes | mv "$backup_dir/.config/" "$backup_dir/config"
    else
        echo "Warning: .config directory does not exist in the backup location."
    end

    # Stage the changes for git
    git add "$backup_dir/*"

    # Call your dotfileCommit function if it exists
    dotfileCommit
end

function dots --description 'alias dots=yadm enter lazygit'
    cd $HOME
    yadm enter lazygit $argv
end
