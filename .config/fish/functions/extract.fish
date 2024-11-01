function clean-unzip --argument zipfile
    if not test (echo $zipfile | string sub --start=-4) = .zip
        echo (status function): argument must be a zipfile
        return 1
    end

    if is-clean-zip $zipfile
        unzip $zipfile
    else
        set folder_name (echo $zipfile | trim-right '.zip')
        set target (basename $folder_name)
        mkdir $target || return 1
        unzip $zipfile -d $target
    end
end

function extract --description "Extract bundled & compressed files"
    set archive $argv[1]

    # Check for arguments
    if test (count $argv) -lt 1
        echo "Usage: extract <archive> [--no-delete]"
        return 1
    end

    # Check if the specified file is an archive
    if not test -f "$archive"
        echo "Error: '$archive' is not a valid file."
        return 1
    end

    # Create target directory based on archive name (remove extension)
    set target_dir (basename "$archive" | sed 's/\.[^.]*$//')
    mkdir -p "$target_dir"

    # Inform about the extraction
    echo -s "Extracting: " (set_color --bold blue) "$archive" (set_color normal)

    # Determine the extraction method
    switch "$archive"
        case '*.tar.bz2' '*.tbz' '*.tbz2'
            tar -xvjf "$archive" -C "$target_dir"
        case '*.tar.gz' '*.tgz'
            tar -xvzf "$archive" -C "$target_dir"
        case '*.tar.xz' '*.txz'
            tar -xvJf "$archive" -C "$target_dir"
        case '*.tar.Z'
            tar -xvZf "$archive" -C "$target_dir"
        case '*.bz2'
            bunzip2 "$archive"
        case '*.rar'
            unrar x "$archive" "$target_dir/"
        case '*.gz'
            gunzip "$archive"
        case '*.zip'
            unzip "$archive" -d "$target_dir"
        case '*.Z'
            uncompress "$archive"
        case '*.7z'
            7za x "$archive" -o"$target_dir"
        case '*'
            echo "Don't know how to extract '$archive'..."
            return 1
    end

    # Prompt to delete the archive after extraction
    read -P "Do you want to delete the archive '$archive'? (y/n): " delete_archive
    if test "$delete_archive" = y
        rm "$archive"
        echo "Deleted '$archive'."
    else
        echo "Keeping the archive '$archive'."
    end

    echo "Extraction complete."
end


function compress --description "Compressed file"
    if test -n "$argv[1]"
        set FILE "$argv[1]"
        switch "$FILE"
            case "*.tar"
                shift
                tar -cf "$FILE" $argv
            case "*.tar.bz2"
                shift
                tar -cjf "$FILE" $argv
            case "*.tar.xz"
                shift
                tar -cJf "$FILE" $argv
            case "*.tar.gz" "*.tgz"
                shift
                tar -czf "$FILE" $argv
            case "*.zip"
                shift
                zip "$FILE" $argv
            case "*.rar"
                shift
                rar a "$FILE" $argv
            case "*"
                echo "Unsupported file type for compression."
        end
    else
        echo "usage: q-compress <file.tar.gz> <files_to_compress>"
    end
end

# function ex --description "Extract bundled & compressed files"
#     if test -f "$argv[1]"
#         switch $argv[1]
#             case '*.tar.bz2'
#                 tar xjf $argv[1]
#             case '*.tar.gz'
#                 tar xzf $argv[1]
#             case '*.bz2'
#                 bunzip2 $argv[1]
#             case '*.rar'
#                 unrar $argv[1]
#             case '*.gz'
#                 gunzip $argv[1]
#             case '*.tar'
#                 tar xf $argv[1]
#             case '*.tbz2'
#                 tar xjf $argv[1]
#             case '*.tgz'
#                 tar xzf $argv[1]
#             case '*.zip'
#                 unzip $argv[1]
#             case '*.Z'
#                 uncompress $argv[1]
#             case '*.7z'
#                 7z $argv[1]
#             case '*.deb'
#                 ar $argv[1]
#             case '*.tar.xz'
#                 tar xf $argv[1]
#             case '*.tar.zst'
#                 tar xf $argv[1]
#             case '*'
#                 echo "'$argv[1]' cannot be extracted via ex"
#         end
#    else
#        echo "'$argv[1]' is not a valid file"
#    end
# end
