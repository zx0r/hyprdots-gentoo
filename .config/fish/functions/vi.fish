function v --wraps=nvim --description 'alias v=nvim'
    nvim $argv
end

function vi --wraps=nvim --description 'alias vi=#env NVIM_APPNAME=$config nvim $argv'
    set -l profile MTnvim
    set -l appname nvim-profiles/$profile
    set -gx NVIM_APPNAME $appname
    nvim $argv
end

###################################################### [[ Neovim Config Switch function ]] ################################

function nvim_switch_config --wraps=nvim --description 'alias ns=#env NVIM_APPNAME=$config nvim $argv'
    # Discover specific Neovim configurations
    set -l profiles (fd --max-depth 1 --glob '*nvim*' $XDG_CONFIG_HOME/nvim-profiles | xargs -n 1 basename)
    set -l config (printf "%s\n" $profiles | fzf --prompt=" Neovim Config > " --height=50% --layout=reverse --border --exit-0)
    set -l profile nvim-profiles/$config


    # Check if no configuration is selected
    if test -z "$config"
        echo "No profile selected."
        return 0
    end

    # Check for the default configuration
    if test "$config" = default
        set -l config ""
    end

    # Set the NVIM_APPNAME environment variable and launch Neovim
    set -gx NVIM_APPNAME $profile
    nvim $argv
end

abbr -a ns nvim_switch_config


###################################################### [[ Neovim Config Switch function ]] ################################

# function nvims
#     set items LazyVim NVim ModernNeovim AstroNvim EcoVim
#     set config (printf "%s\n" $items | fzf --prompt=" Neovim Config = " --height=50% --layout=reverse --border --exit-0)
#     if [ -z $config ]
#         echo "Nothing selected"
#         return 0
#     else if [ $config = default ]
#         set config ""
#     end
#     env NVIM_APPNAME=$config nvim $argv
# end

#bind \ca 'nvims\n'```

###################################################### [[ ALIASES ]] ######################################################
