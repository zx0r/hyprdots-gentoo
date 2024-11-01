###################################################### [[ Dotfiles ]] ################################

# NOTE Dotfiles manafer version
#https://github.com/Vaelatern/init-dotfiles/blob/master/init_dotfiles.sh
#https://github.com/anishathalye/dotbot.git
#https://marcel.is/managing-dotfiles-with-git-bare-repo/

# https://bitbucket.org/durdn/cfg/src/master/.bin/install.sh
# htps://news.ycombinator.com/item?id=32632533
# htps://www.atlassian.com/git/tutorials/dotfiles
# https://github.com/TheLocehiliosan/yadm
# htps://github.com/RichiH/vcsh

# # TODO: copy the below function into your .*rc file
# # function config; /usr/bin/git --git-dir='$HOME/.dotfiles/' --work-tree='$HOME'; end
# #
# alias config '/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
# alias ctm 'commit -a -u -m'

# Check current remote
# dot check
#
# # Add fresh remote
# dot create_repo
#
# # Delete repository
# gh repo delete zx0r/hyprdots-gentoo --yes && rm -vrf -rf ~/hyprdots-gentoo
#
# # Remove existing remote if needed
# git --git-dir=$HOME/hyprdots-gentoo --work-tree=$HOME remote remove origin
#
# # Verify deletion
# gh repo list

function dot
    # User and repository settings
    set -l user zx0r
    set -l email d0t_machine@proton.me

    set -l repo_name hyprdots-gentoo
    set -l repo_desc "Optimized Gentoo Linux development environment featuring Hyprland, custom USE flags, and optimized toolchain"

    set -l dotDir "$HOME/$repo_name"
    set -l cmd "git --git-dir=$dotDir --work-tree=$HOME"

    # Config paths - using an array for better organization
    set -l configs foot tmux fish bat bob btop cava easyeffects eza fd fastfetch \
        fzf gh kitty Kvantum lazydocker lazygit lsd mako neofetch neovide \
        obs-studio ripgrep rofi starship waybar wget wlogout wofi yazi \
        zathura zsh

    # Flag and system files
    set -l flags chromium-flags.conf spotify-flags.conf thorium-flags.conf code-flags.conf
    set -l system colorsdb iconsdb user-dirs.dirs user-dirs.locale

    # Build backup files list dynamically
    set -l backupfiles "$HOME/.xinitrc"

    for config in $configs
        set backupfiles $backupfiles "$XDG_CONFIG_HOME/$config"
    end
    for flag in $flags
        set backupfiles $backupfiles "$XDG_CONFIG_HOME/$flag"
    end
    for sys in $system
        set backupfiles $backupfiles "$XDG_CONFIG_HOME/$sys"
    end

    # Command handling with improved feedback
    switch $argv[1]
        case check
            if not test -d "$dotDir"
                echo "🔄 Repository not initialized"
                echo "🎯 Run 'dot setup' to get started"
                return 2
            end

            set -l remote_url (eval $cmd remote get-url origin 2>/dev/null)
            if test $status -eq 0
                echo "🔍 Remote found: $remote_url"
                ssh -T git@github.com &>/dev/null
                if test $status -eq 1
                    echo "✅ SSH connection verified"
                    eval $cmd remote -v
                else
                    echo "🔑 Configure SSH keys for GitHub"
                end
            else
                echo "📝 Remote not configured - run 'dot create_repo'"
            end

        case setup
            git init --bare $dotDir

            eval $cmd config user.name "$user"
            eval $cmd config user.email "$email"

            eval $cmd config --local status.showUntrackedFiles no
            gh repo create $repo_name --public --description "$repo_desc"
            eval $cmd remote add origin "git@github.com:$user/$repo_name.git"

            for file in $backupfiles
                eval $cmd add $file 2>/dev/null
            end
            eval $cmd commit -m "Initial setup: Dotfiles configuration"
            eval $cmd branch -M main
            eval $cmd push -u origin main

            echo "✅ Setup complete! Your dotfiles are ready!"

        case create_repo
            gh repo create $repo_name --public --description "$repo_desc"
            eval $cmd remote add origin "git@github.com:$user/$repo_name.git"
            echo "📦 GitHub repository created!"

        case init
            git init --bare $dotDir
            eval $cmd config --local status.showUntrackedFiles no

            for file in $backupfiles
                eval $cmd add $file 2>/dev/null
            end
            echo "✨ Dotfiles initialized and files tracked!"

        case commit
            set -l msgCommit $argv[2..-1]
            test -z "$msgCommit"; and set msgCommit "Update dotfiles"
            eval $cmd commit -a -u -m "$msgCommit"
            echo "📝 Changes committed: $msgCommit"

        case push
            # eval $cmd push -u origin
            eval $cmd push --set-upstream origin main
            echo "🚀 Changes pushed to remote!"

        case status
            echo "📊 Current repository status:"
            eval $cmd status

        case add
            eval $cmd add $argv[2..-1]
            echo "✅ Files added to tracking!"

        case '*'
            echo "🔧 Usage: dot [setup|create_repo|check|add|init|commit|push|status]"
            echo "Commands:"
            echo "  setup             Complete repository setup"
            echo "  check            Verify repository and connection"
            echo "  add [files]       Track new files"
            echo "  init              Initialize repository"
            echo "  commit [message]  Save changes"
            echo "  push              Upload to GitHub"
            echo "  status            View current state"
    end
end

function dotfiles-branch
    # Repository settings
    # main: Base configuration
    # laptop: Laptop-specific settings
    # desktop: Desktop workstation setup
    # work: Work environment
    # minimal: Minimal configuration
    # experimental: Testing new setups

    set -l dotDir "$HOME/hyprdots-gentoo"
    set -l cmd "git --git-dir=$dotDir --work-tree=$HOME"

    switch $argv[1]
        case new
            # Create and switch to new branch
            eval $cmd checkout -b $argv[2]
            echo "🌿 Created and switched to branch: $argv[2]"

        case switch
            # Switch to existing branch
            eval $cmd checkout $argv[2]
            echo "🔄 Switched to branch: $argv[2]"

        case list
            # List all branches
            eval $cmd branch
            echo "📋 Current branches listed above"

        case merge
            # Merge specified branch into current
            eval $cmd merge $argv[2]
            echo "🔗 Merged branch $argv[2] into current branch"

        case '*'
            echo "Usage: dotfiles-branch [new|switch|list|merge] [branch-name]"
            echo "Examples:"
            echo "  dotfiles-branch new laptop      # Create laptop config branch"
            echo "  dotfiles-branch switch desktop  # Switch to desktop config"
            echo "  dotfiles-branch list            # Show all branches"
            echo "  dotfiles-branch merge laptop    # Merge laptop into current"
    end
end



function dotfiles --description 'Manage dotfiles with bare git repository'
    # Initialize variables
    set -l dotDir "$HOME/.dotfiles"
    set -l cmd "git --git-dir=$dotDir --work-tree=$HOME"

    switch $argv[1]
        case init
            # Initialize bare repository
            git init --bare $dotDir
            # Set git configuration
            eval $cmd config --local status.showUntrackedFiles no

            # Add alias to fish config
            echo "alias dot='git --git-dir=$dotDir --work-tree=\$HOME'" >>$HOME/.config/fish/config.fish

            echo "✨ Dotfiles repository initialized at $dotDir"
            echo "🔥 Use 'dot' command to manage your dotfiles"

        case clone
            if test (count $argv) -lt 2
                echo "Usage: dotfiles clone <repository-url>"
                return 1
            end

            # Clone bare repository
            git clone --bare $argv[2] $dotDir

            # Create backup directory
            mkdir -p $HOME/.config-backup

            # Attempt checkout
            eval $cmd checkout 2>/tmp/checkout.tmp
            if test $status -ne 0
                echo "🔄 Backing up pre-existing dotfiles..."
                set -l files (egrep "\s+\." /tmp/checkout.tmp | awk '{print $1}')
                for file in $files
                    mv $HOME/$file $HOME/.config-backup/
                end
                eval $cmd checkout
            end

            # Configure repository
            eval $cmd config --local status.showUntrackedFiles no

            echo "✨ Dotfiles cloned and configured successfully!"

        case add
            eval $cmd add $argv[2..-1]

        case commit
            eval $cmd commit -a -m "$argv[2..-1]"

        case push
            eval $cmd push

        case status
            eval $cmd status

        case '*'
            echo "Usage: dotfiles [init|clone|add|commit|push|status]"
            echo "Commands:"
            echo "  init              Initialize new dotfiles repository"
            echo "  clone <url>       Clone existing dotfiles repository"
            echo "  add <files>       Add files to track"
            echo "  commit <message>  Commit changes"
            echo "  push             Push changes to remote"
            echo "  status           Check repository status"
    end
end
