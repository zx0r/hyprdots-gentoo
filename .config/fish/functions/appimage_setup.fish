function appimage_setup
    set -l app $argv

    # Check if appimagetool is available
    if not command -v appimagetool &>/dev/null
        echo "appimagetool not found. Please install it first."
        return 1
    end

    # Install FUSE if not already installed
    if not command -v fusermount &>/dev/null
        echo "Installing FUSE..."
        sudo emerge --ask sys-fs/fuse:0
    end

    # Extract AppImage
    echo "Extracting AppImage..."
    appimagetool --appimage-extract

    # Make AppRun executable
    echo "Setting permissions..."
    chmod +x squashfs-root/AppRun

    # Create symbolic link (adjust paths as needed)
    echo "Creating symbolic link..."
    ln -s squashfs-root/AppRun ~/.local/bin/$app

    echo "AppImage setup complete!"
end
