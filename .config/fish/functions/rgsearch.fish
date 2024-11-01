function find_files --description "Lists files in the current directory, respecting .gitignore"
    command fd --type f --hidden --exclude .git
end
abbr -a ff find_files

function git_files --description "Fuzzy search through git tracked files"
    command git ls-files | fzf
end

function grep_string --description "Searches for the string under the cursor or selection in the current directory"
    set -l search_string (command xclip -o) # Assumes you have xclip installed to get clipboard content
    command rg --hidden --no-ignore --glob '!.git/*' "$search_string"
end

function live_grep --description "Live search for a string in the current directory"
    rg --hidden --no-ignore --glob '!.git/*' --line-number --smart-case --colors "path:green" --colors "line:blue" --colors "match:yellow" | fzf --preview 'bat --style=numbers --color=always {}'
end
abbr -a lg live_grep
