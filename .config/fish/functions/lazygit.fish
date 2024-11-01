function lazygit
    set repo (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$repo"
        cd $repo
        command lazygit
    else
        echo "Not in a Git repository."
    end
end

function lazygit-recent
    set repo (find ~ -type d -name ".git" 2>/dev/null | sed 's|/\.git||' | fzf --prompt "Select a Git repo: ")
    if test -n "$repo"
        cd $repo
        lazygit
    else
        echo "No repository selected."
    end
end
