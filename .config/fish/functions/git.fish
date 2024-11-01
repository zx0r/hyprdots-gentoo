
# Abbreviations for core commands
#
# Usage:  gh <command> <subcommand> [flags]
#
abbr -a auth 'gh auth' # Authenticate gh and git with GitHub
# abbr -a ghb 'gh browse' # Open the repository in the browser
# abbr -a ghcs 'gh codespace' # Connect to and manage codespaces
# abbr -a ghs 'gh gist' # Manage gists
# abbr -a ghi 'gh issue' # Manage issues
# abbr -a gho 'gh org' # Manage organizations
# abbr -a ghpr 'gh pr' # Manage pull requests
# abbr -a ghproj 'gh project' # Work with GitHub Projects
# abbr -a ghr 'gh release' # Manage releases
# abbr -a ghrepo 'gh repo' # Manage repositories

# Abbreviations for GitHub Actions commands
abbr -a ghc 'gh cache' # Manage GitHub Actions caches
abbr -a ghrun 'gh run' # View details about workflow runs
abbr -a ghworkflow 'gh workflow' # View details about GitHub Actions workflows

# Abbreviations for alias commands
abbr -a clone 'gh repo clone' # Alias for "repo clone"
abbr -a ghco 'gh pr checkout' # Alias for "pr checkout"
abbr -a gho 'gh repo view' # Alias for "repo view"
abbr -a ghob 'gh repo view --web' # Alias for "repo view --web"
abbr -a ghrepos 'gh api --paginate graphql -f owner="$1" -f query="\\n  query($owner: String!, $... "' # Shell alias for repos command

# Abbreviations for additional commands
# abbr -a gha 'gh alias' # Create command shortcuts
# abbr -a ghaapi 'gh api' # Make an authenticated GitHub API request
# abbr -a ghaattestation 'gh attestation' # Work with artifact attestations
# abbr -a ghcompletion 'gh completion' # Generate shell completion scripts
# abbr -a ghconfig 'gh config' # Manage configuration for gh
# abbr -a ghextension 'gh extension' # Manage gh extensions
# abbr -a ghgpg 'gh gpg-key' # Manage GPG keys
# abbr -a ghlabel 'gh label' # Manage labels
# abbr -a ghruleset 'gh ruleset' # View info about repo rulesets
# abbr -a ghsearch 'gh search' # Search for repositories, issues, and pull requests
# abbr -a ghsecret 'gh secret' # Manage GitHub secrets
# abbr -a ghssh 'gh ssh-key' # Manage SSH keys
# abbr -a ghstatus 'gh status' # Print information about relevant issues, pull requests, and notifications
# abbr -a ghvariable 'gh variable' # Manage GitHub Actions variables
#
# # Abbreviation for displaying usage
# abbr -a ghus 'gh usage  <subcommand> [flags]' # Display usage information for gh

# Basics
abbr -a g git # Git command
abbr -a gs "git status" # List changed files
abbr -a ga "git add" # Add <files> to the next commit
abbr -a gaa "git add ." # Add all changed files
abbr -a grm "git rm" # Remove <file>
abbr -a gc "git commit" # Commit staged files, needs -m ""
abbr -a gps "git push" # Push local commits to <origin> <branch>
abbr -a gpl "git pull" # Pull changes with <origin> <branch>
abbr -a gf "git fetch" # Download branch changes, without modifying files

# Merging and Rebasing
abbr -a grb "git rebase" # Rebase the current HEAD into <branch>
abbr -a grba "git rebase --abort" # Cancel current rebase session
abbr -a grbc "git rebase --continue" # Continue onto next diff
abbr -a gm "git merge" # Merge <branch> into your current HEAD

# Repo setup
abbr -a gi "git init" # Initialize a new empty local repo
abbr -a gcl "git clone" # Downloads repo from <url>

# Branching
abbr -a gch "git checkout" # Switch the HEAD to <branch>
abbr -a gb "git branch" # Create a new <branch> from HEAD
abbr -a gd "git diff" # Show all changes to untracked files
abbr -a gtree "git log --graph --oneline --decorate --abbrev-commit" # Show branch tree
abbr -a gl "git log" # Show commit logs

# Tags
abbr -a gt "git tag" # Tag the current commit, 1 param
abbr -a gtl "git tag -l" # List all tags, optionally with pattern
abbr -a gtlm "git tag -n" # List all tags, with their messages
abbr -a gtp "git push --tags" # Publish tags

# Origin
abbr -a gr "git remote" # Manage remote repositories
abbr -a grs "git remote show" # Show current remote origin
abbr -a grl "git remote -v" # List all currently configured remotes
abbr -a grr "git remote rm origin" # Remove current origin
abbr -a gra "git remote add" # Add new remote origin
abbr -a grurl "git remote set-url origin" # Set URL of existing origin

# Undoing
abbr -a guc "git revert" # Revert a <commit>
abbr -a gu "git reset" # Reset HEAD pointer to a <commit>, preserves changes
abbr -a gua "git reset --hard HEAD" # Resets all uncommitted changes
abbr -a gnewmsg "git commit --amend -m" # Update <message> of previous commit
abbr -a gclean "git clean -df" # Remove all untracked files

# Git LFS
abbr -a glfsi "git lfs install" # Install Git LFS
abbr -a glfst "git lfs track" # Track files with Git LFS
abbr -a glfsls "git lfs ls-files" # List tracked LFS files
abbr -a glfsmi "git lfs migrate import --include " # Migrate files to LFS

# Fish shell Git functions and aliases

# Abbreviated command to push LFS changes to the current branch
abbr -a gplfs 'git lfs push origin (git_current_branch) --all' # Push LFS changes to current branch

# Navigate to the project root (where .git is)
function jump-to-git-root
    set _root_dir (git rev-parse --show-toplevel 2>/dev/null)
    if test $status -ne 0
        echo -e '\033[1;93m Not a Git repo\033[0m'
        return 1
    end

    set _pwd (pwd)
    if test $_pwd = $_root_dir
        # Handle submodules
        set _root_dir (git -C (dirname $_pwd) rev-parse --show-toplevel 2>/dev/null)
        if test $status -ne 0
            echo "\033[0;96m Already at Git repo root.\033[0m"
            return 0
        end
    end

    # Make `cd -` work.
    set OLDPWD $_pwd
    echo "\033[0;96m Git repo root: $_root_dir\033[0m"
    cd $_root_dir
end

# Abbreviation for jumping to the Git root
abbr -a gj jump-to-git-root # Navigate back to project root

# Shorthand for cloning a Git repository
function clone
    set default_service 'github.com' # Default service used if full URL isn't specified
    set default_username lissy93 # Default username used if repo org/username isn't specified
    set use_ssh true # Use SSH instead of HTTPS
    set user_input $argv[1]
    set target $argv[2]

    # Help flag passed, show manual and exit  
    if test "$user_input" = --help -o "$user_input" = -h
        echo -e 'This will clone a git repo and cd into it.'
        echo -e 'Either specify repo name, user/repo, or a full URL.'
        echo -e 'If no target directory is specified, the repo name will be used.'
        echo -e 'E.g. `$ clone lissy93/dotfiles`'
        return
    end

    # No input specified, prompt user
    if test (count $argv) -eq 0
        echo 'Enter a user/repo or full URL: '
        read user_input
    end

    # Determine input type and make clone URL
    if test "$user_input" = "git@"* -o "$user_input" = "*://*"
        set REPO_URL $user_input
    else if test "$user_input" = "*/"*
        if test "$use_ssh" = true
            set REPO_URL "git@$default_service:$user_input.git"
        else
            set REPO_URL "https://$default_service/$user_input.git"
        end
    else
        if test "$use_ssh" = true
            set REPO_URL "git@$default_service:$default_username/$user_input.git"
        else
            set REPO_URL "https://$default_service/$default_username/$user_input.git"
        end
    end

    # Clone repo
    git clone $REPO_URL $target

    # cd into newly cloned directory
    cd (basename "$_" .git)

    # Print results
    if test "$status" -eq 0
        echo -e "☑️  \033[1;96mCloned $REPO_URL into (pwd), and cd'd into it.\033[0m"
    else
        echo -e "❌ \033[1;91mFailed to clone $REPO_URL\033[0m"
    end
end

# Sync fork against upstream repo
function gsync
    # If no upstream origin provided, prompt user for it
    if not git remote -v | grep -q upstream
        echo 'Enter the upstream git URL: '
        read url
        git remote add upstream "$url"
    end
    git remote -v
    git fetch upstream
    git pull upstream master
    git checkout master
    git rebase upstream/master
end

# Commit with -m option
function gcommit
    set commit_msg $argv
    if test (count $argv) -eq 0
        echo 'Enter a commit message'
        read commit_msg
    end
    git commit -m "$commit_msg"
end

# Abbreviation for git commit
abbr -a gcm gcommit # Make git commit with -m

# Fetch, rebase and push updates to the current branch
function gfetchrebase
    set branch master
    if test -n "$argv[1]"
        set branch $argv[1]
    end
    git fetch upstream
    git rebase upstream/$branch
    git push
end

# Abbreviation for fetch, rebase
abbr -a gfrb gfetchrebase # Fetch, rebase and push updates

# Integrates with gitignore.io to auto-populate .gitignore file

function gignore
    # Fetch the gitignore template from gitignore.io
    if test (count $argv) -eq 0
        echo "Usage: gignore [template...]"
        echo "Example: gignore python node"
        return 1
    end

    # Join all arguments into a single string separated by commas
    set templates (string join , $argv)

    # Fetch the .gitignore template
    curl -fL "https://www.gitignore.io/api/$templates" -o .gitignore

    # Print success message
    if test $status -eq 0
        echo "Successfully fetched .gitignore for: $templates"
    else
        echo "Failed to fetch .gitignore for: $templates"
    end
end


# Helper function to return URL of the current repo (based on origin)
function get-repo-url
    set git_base_url 'https://github.com'
    # Get origin from git repo and remove .git
    set git_url (git config --get remote.origin.url | string trim -r '.git')
    # Process URL and append branch / working origin 
    if test "$git_url" =~ ^git@
        set branch (git symbolic-ref --short HEAD)
        set branchExists (git ls-remote --heads $git_url $branch | wc -l)
        set github (string replace -r 'git@|:' '' $git_url) # Remove git@ and replace : with /
        if test $branchExists -eq 1
            set git_url "http://$github/tree/$branch"
        else
            set git_url "http://$github"
        end
    else if test "$git_url" =~ ^https?://
        set branch (git symbolic-ref --short HEAD)
        set branchExists (git ls-remote --heads $git_url $branch | wc -l)
        if test $branchExists -eq 1
            set git_url "$git_url/tree/$branch"
        else
            set git_url "$git_url"
        end
    end
    # Return URL
    echo $git_url
end

# Launches a URL in the system's default browser
function launch-url
    if hash open 2>/dev/null
        set open_command open
    else if hash xdg-open 2>/dev/null
        set open_command xdg-open
    else if hash lynx 2>/dev/null
        set open_command lynx
    else
        echo -e "\033[0;33mUnable to launch browser, open manually instead"
        echo -e "\033[1;96m🌐 URL: \033[0;96m\e[4m$1\e[0m"
        return
    end
    echo $open_command
end

# Opens the current repo + branch in GitHub
function open-github
    set git_base_url 'https://github.com' # Modify this if using GH enterprise
    if test -n "$argv[1]" -a -n "$argv[2]"
        # User specified a repo
        set git_url "$git_base_url/$argv[1]/$argv[2]"
    else if git rev-parse --git-dir >/dev/null 2>&1
        # Get URL from current repo's origin
        set git_url (get-repo-url)
    else
        # Not in repo, and nothing specified, open homepage
        set git_url "$git_base_url"
    end

    # Determine which open command is supported
    set open_command (launch-url $git_url)
    # Print messages
    echo -e "\033[1;96m🐙 Opening in browser: \033[0;96m\e[4m$git_url\e[0m"
    # And launch!
    eval $open_command $git_url
end

# Abbreviation for opening GitHub
abbr -a gho open-github # Open current repo on GitHub

# Opens the pull request tab for the current GitHub repo
function open-github-pulls
    # Get Repo URL
    if git rev-parse --git-dir >/dev/null 2>&1
        set git_url (get-repo-url)
    else
        set git_url 'https://github.com'
    end
    set git_url "$git_url/pulls"

    # Get open command
    set open_command (launch-url $git_url)
    echo -e "\033[1;96m🐙 Opening Pull Requests in browser: \033[0;96m\e[4m$git_url\e[0m"
    eval $open_command $git_url
end

# Abbreviation for opening GitHub pull requests
abbr -a gpr open-github-pulls # Open Pull Requests in GitHub

# Opens the issues tab for the current GitHub repo
function open-github-issues
    # Get Repo URL
    if git rev-parse --git-dir >/dev/null 2>&1
        set git_url (get-repo-url)
    else
        set git_url 'https://github.com'
    end
    set git_url "$git_url/issues"

    # Get open command
    set open_command (launch-url $git_url)
    echo -e "\033[1;96m🐙 Opening Issues in browser: \033[0;96m\e[4m$git_url\e[0m"
    eval $open_command $git_url
end

# Abbreviation for opening GitHub issues
abbr -a gih open-github-issues # Open Issues in GitHub

# Provides info on a specific pull request
function pr-info
    # If no PR number is specified, prompt user
    if test -z "$argv[1]"
        echo 'Enter Pull Request number:'
        read pr_num
    else
        set pr_num $argv[1]
    end
    echo "Fetching details for PR #$pr_num..."
    curl -s "https://api.github.com/repos/$(get-repo-url)/pulls/$pr_num" | jq '.'
end

# Abbreviation for getting pull request info
abbr -a gprinfo pr-info # Get PR info

# List all Git remotes
function list-remotes
    git remote -v
end

# Abbreviation for listing Git remotes
abbr -a grm list-remotes # List Git remotes
