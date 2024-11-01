#https://github.com/Lissy93/dotfiles/blob/master/config/zsh/aliases/node-js.zsh
#
# Yarn - Project commands
abbr -a ys 'yarn start' # Start the Yarn project
abbr -a yt 'yarn test' # Run tests using Yarn
abbr -a yb 'yarn build' # Build the Yarn project
abbr -a yl 'yarn lint' # Lint the Yarn project
abbr -a yd 'yarn dev' # Start development server with Yarn
abbr -a yp 'yarn publish' # Publish the package with Yarn
abbr -a yr 'yarn run' # Run Yarn scripts

# Yarn - Package management
abbr -a ya 'yarn add' # Add a package using Yarn
abbr -a ye 'yarn remove' # Remove a package using Yarn
abbr -a yi 'yarn install' # Install packages with Yarn
abbr -a yg 'yarn upgrade' # Upgrade packages with Yarn
abbr -a yu 'yarn update' # Update packages with Yarn
abbr -a yf 'yarn info' # Get information about a package

# Yarn - Misc
abbr -a yz 'yarn audit' # Run security audits with Yarn
abbr -a yc 'yarn autoclean' # Clean up unused files with Yarn
abbr -a yk 'yarn check' # Check the integrity of Yarn packages
abbr -a yh 'yarn help' # Get help for Yarn commands

# Aliases for older NPM projects
abbr -a npmi 'npm install' # Install packages using NPM
abbr -a npmu 'npm uninstall' # Uninstall packages using NPM
abbr -a npmr 'npm run' # Run NPM scripts
abbr -a npms 'npm start' # Start the NPM project
abbr -a npmt 'npm test' # Run tests using NPM
abbr -a npml 'npm run lint' # Lint the NPM project
abbr -a npmd 'npm run dev' # Start development server with NPM
abbr -a npmp 'npm publish' # Publish the package with NPM

# NVM commands
abbr -a nvmi 'nvm install' # Install a Node version using NVM
abbr -a nvmu 'nvm use' # Use a Node version with NVM
abbr -a nvml 'nvm ls' # List installed Node versions with NVM
abbr -a nvmr 'nvm run' # Run a command with NVM
abbr -a nvme 'nvm exec' # Execute a command in a specific Node version with NVM
abbr -a nvmw 'nvm which' # Show the path of the current Node version with NVM
abbr -a nvmlr 'nvm ls-remote' # List remote Node versions with NVM
abbr -a nvmlts 'nvm install --lts && nvm use --lts' # Install and use the latest LTS Node version
abbr -a nvmlatest 'nvm install node --latest-npm && nvm use node' # Install the latest Node version
abbr -a nvmsetup install_nvm # Install NVM

# Special Node commands
abbr -a npmscripts 'cat package.json | jq .scripts' # Print available scripts for the current project
abbr -a docker-node 'docker run -it --rm -v "$(pwd)":/usr/src/app -w /usr/src/app node' # Run Node using Docker
abbr -a nodesize 'du -sh node_modules' # Print size of node_modules folder

# Shortcuts for helper functions defined below
abbr -a yv print_node_versions # Print versions of Node.js and related packages
abbr -a yarn-nuke reinstall_modules # Fully remove and reinstall node_modules
abbr -a repo open_repo # Opens the current remote Git repository in the browser
abbr -a npmo open-npm # Open given NPM module in browser
abbr -a nodeo node-docs # Open Node.js docs for specific function in browser

# Enable auto-Node version switching based on .nvmrc file in the current directory
function load_nvmrc
    set nvmrc_path ".nvmrc"
    if test -f $nvmrc_path
        nvm use --lts
    end
end

function nvm_auto_switch
    add-zsh-hook chpwd load_nvmrc
end

# Nuke - Helper to remove node_modules and the lock file, then reinstall
function reinstall_modules
    read -P "Remove and reinstall all node_modules? (y/N) " choice
    if test "$choice" = y -o "$choice" = Y
        set project_dir (pwd)

        # Check file exists, remove it and print message
        function check_and_remove
            if test -d "$project_dir/$argv[1]"
                echo -e "\e[35mRemoving $argv[1]...\e[0m"
                rm -rf "$project_dir/$argv[1]"
            end
        end

        # Delete node_modules and lock files
        check_and_remove node_modules
        check_and_remove 'yarn.lock'
        check_and_remove 'package-lock.json'

        # Reinstall with yarn (or NPM)
        if command -v yarn >/dev/null
            echo -e "\e[35mReinstalling with yarn...\e[0m"
            yarn
            echo -e "\e[35mCleaning Up...\e[0m"
            yarn autoclean
        else if command -v npm >/dev/null
            echo -e "\e[35mReinstalling with NPM...\e[0m"
            npm install
        else
            echo -e "🚫\033[0;91m Unable to proceed, yarn/npm not installed\e[0m"
        end
    else
        echo -e "\n\033[0;91mAborting...\e[0m"
    end
end

# Prints out versions of core Node.js packages
function print_node_versions
    set versions ''

    function format_version_number
        echo "$($argv[1] --version 2>&1 | head -n 1 | sed 's/[^0-9.]*//g')"
    end

    function get_version
        if command -v $argv[1] >/dev/null
            set versions "$versions\e[36m\e[1m $argv[2]: \033[0m$(format_version_number $argv[1]) \n\033[0m"
        else
            set versions "$versions\e[33m\e[1m $argv[2]: \033[0m\033[3m Not installed\n\033[0m"
        end
    end

    # Source NVM if not yet done
    if type -q source_nvm
        source_nvm
    end

    # Print versions of core Node things
    get_version node 'Node.js'
    get_version npm NPM
    get_version corepack Corepack
    get_version yarn Yarn
    get_version nvm NVM
    get_version ni ni
    get_version pnpm pnpm
    get_version tsc TypeScript
    get_version bun Bun
    get_version deno Deno
    get_version git Git
    echo -e $versions
end

# Location of NVM, will inherit from .zshenv if set
set NVM_DIR (status --is-login; and echo "$HOME/.nvm")

# On first time using Node command, import NVM if present and not yet sourced
function source_nvm
    if test -f "$NVM_DIR/nvm.sh" -a ! (command -v nvm > /dev/null)
        echo -e "\033[1;93mInitializing NVM...\033[0m"
        source "$NVM_DIR/nvm.sh"
        nvm use default
    end
end

# Helper function to enable Corepack / use Yarn
function enable_corepack
    if not command -v yarn >/dev/null -a command -v corepack >/dev/null
        echo -e "\033[1;93mEnabling Corepack...\033[0m"
        corepack enable
    else
        echo -e "\033[1;31mCorepack already enabled, skipping...\033[0m"
    end
end

# Wrapper function for Yarn, which sets up Yarn if it's not yet found
function yarn_wrapper
    if not command -v yarn >/dev/null
        echo "Yarn not found, enabling Corepack..."
        enable_corepack
    end
    yarn $argv
end

function yarn
    yarn_wrapper $argv
end

# Helper function to install NVM
function install_nvm
    set nvm_repo 'https://github.com/nvm-sh/nvm.git'
    if test -d "$NVM_DIR"
        cd $NVM_DIR
        git pull
    else
        read -P "Install NVM now? (y/N) " choice
        if test "$choice" = y -o "$choice" = Y
            echo -e "\nInstalling..."
            git clone $nvm_repo $NVM_DIR
            cd $NVM_DIR
            git checkout v0.39.3
        else
            echo -e "\nAborting..."
            return
        end
    end
    # All done, import / re-import NVM script
    source "$NVM_DIR/nvm.sh"
    # Then install Node LTS
    nvm install --lts
end

# Helper function that gets supported open method for system
function launch_url
    if command -v open >/dev/null
        set open_command open
    else if command -v xdg-open >/dev/null
        set open_command xdg-open
    else if command -v lynx >/dev/null
        set open_command lynx
    else
        echo -e "\033[0;33mUnable to launch browser, open manually instead"
        echo -e "\033[1;96m🌐 URL: \033[0;96m\e[4m$argv[1]\e[0m"
        return
    end
    eval "$open_command $argv[1]"
end

# Open Node.js docs, either specific page or show all
function node_docs
    set section (status --is-login; and echo $argv[1]; or echo all)
    launch_url "https://nodejs.org/docs/$(node --version)/api/$section.html"
end

# Launches npmjs.com on the page of a specific module
function open_npm
    set npm_base_url 'https://www.npmjs.com'
    if test (count $argv) -ne 0
        set npm_url $npm_base_url/package/$argv[1]
    else
        set npm_url $npm_base_url
    end
    echo -e "\033[1;96m📦 Opening in browser: \033[0;96m\e[4m$npm_url\e[0m"
    launch_url $npm_url
end

# Open remote git repository
function open_repo
    set repo_url (git config --get remote.origin.url)
    if test "$repo_url" != ""
        set repo_url (string replace "git@" "https://" $repo_url)
        set repo_url (string replace ".git" "" $repo_url)
        set repo_url (string replace ":" "/" $repo_url)
        launch_url $repo_url
    else
        echo "No remote repository found."
    end
end
