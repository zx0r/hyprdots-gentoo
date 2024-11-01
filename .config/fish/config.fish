#https://github.com/drduh/config/blob/master/zshrc
#https://github.com/Lissy93/dotfiles/tree/master/.github

thefuck --alias | source
fish_ssh_agent


if status is-login
    dbus-launch --exit-with-session Hyprland
end

if status is-interactive
    set -g fish_greeting
    #fish_vi_key_bindings
    source $XDG_CONFIG_HOME/fish/abbr.fish
    source $XDG_CONFIG_HOME/fish/colorscheme.fish
    source $XDG_CONFIG_HOME/fish/user_variables.fish
    #source $HOME/miniconda3/etc/fish/conf.d/conda.fish

    source $XDG_CONFIG_HOME/fish/functions/fish_ssh_agent.fish
    source $HOME/.secrets/config.fish.local
end


# NOTE DIRCOLORS
# -----------------------------------------------------------------------------
#
# if test -f $HOME/.dircolors
set LS_COLORS $XDG_CONFIG_HOME/iconsdb
# set LS_COLORS (dircolors -b ~/.dircolors)

# Source conda configuration if it exists
if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
    source "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
end

# # Source mamba configuration if it exists
if test -f "$HOME/miniconda3/etc/fish/conf.d/mamba.fish"
    source "$HOME/miniconda3/etc/fish/conf.d/mamba.fish"
end

#-----------------------------# PATH #----------------------------------------#

set -x fish_user_paths
fish_add_path /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/lib/go/bin /usr/lib/rustup/bin
fish_add_path $XDG_BIN_DIR $BOB_HOME $GOPATH/bin $CARGO_HOME/bin $NODE_PATH $RIPGREP_CONFIG_PATH $BUN_PATH $CONDA_PATH

#-----------------------------------------------------------------------------#

#---# NVM hook fisher install jorgebucaran/nvm.fish #-------------------------#

set --universal nvm_default_version latest
set --universal nvm_default_packages npm

#-----------------------------------------------------------------------------#

set -U fish_history_ignore 'cd*' 'ls*' 'eza*' 'uname*' clear date exit reboot poweroff pwd history which whoami whois unzip upload uptime useradd egrep pgrep head hostname
