# Function to swap two files
function swap_files
    mv "$1" "$1.old"
    mv "$2" "$1"
    mv "$1.old" "$2"
end
