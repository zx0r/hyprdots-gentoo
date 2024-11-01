# Fish Shell Function for Automating Nerd Fonts Installation
function install_nerd_fonts
    # Downloading Nerd Fonts
    set url "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/..."

    # Checking for existing installation
    if test -e /usr/share/fonts/nerd-fonts
        echo "Nerd Fonts already installed."
        return 0
    end

    echo "Downloading Nerd Fonts from $url..."
    curl -L $url -o /tmp/nerd-fonts.zip

    # Error handling
    if test $status -ne 0
        echo "Error downloading Nerd Fonts."
        return 1
    end

    # Extracting the zip file
    echo "Extracting Nerd Fonts..."
    unzip /tmp/nerd-fonts.zip -d /usr/share/fonts/

    # Security consideration: remove downloaded zip after installation
    rm /tmp/nerd-fonts.zip

    # Updating font cache
    fc-cache -fv

    echo "Nerd Fonts successfully installed."
end
