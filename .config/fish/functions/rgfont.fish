# Function to search for fonts
function rgfont
    set -l font "$argv[1]"
    fc-list | rg -o '[^/]*$[^:]*' | awk -F':' '{print $1}' | grep $font | fzf --height 50% --reverse | wl-copy
end
