#https://github.com/angelofallars/dotfiles/blob/main/scripts/my-tmux-sessionizer
#https://github.com/awarewen/my_dotfiles/blob/main/Config/hypr/scripts/misc/swww_randomize.bk

function project_selector
    set -x FZF_DEFAULT_OPTS " \
    --color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

    set lavender "#b4befe"
    set maroon "#eba0ac"
    set peach "#fab387"
    set subtext0 "#a6adc8"
    set overlay2 "#9399b2"
    set overlay0 "#6c7086"
    set surface2 "#585b70"
    set surface1 "#45475a"
    set surface0 "#313244"
    set base_minus_1 "#262637"
    set base "#1e1e2e"
    set mantle "#181825"

    set projects (
        find \
            ~/projects/* \
            ~/forks \
            ~/study \
            -mindepth 1 -maxdepth 1 \
            -follow \
            -type d \
            -printf "%T@ %p\n" | \
        sort -n -r | \
        sed -E "s/\w*\.\w* //" | \
        sed -E "s|^$HOME/||g" | \
        sed -E "s|^projects/work|📋 work|g" | \
        sed -E "s|^projects/axyl|🔷 axyl|g" | \
        sed -E "s|^projects/waycrate|🟨 waycrate|g" | \
        sed -E "s|^projects/personal/|🟢 |g" | \
        sed -E "s|^projects/silver|💿 silver|g" | \
        sed -E "s|^projects/(\S*)|🔲 \1|g" | \
        sed -E "s|^forks|↔️  forks|g" | \
        sed -E "s|^study|✏️  study|g"
    )

    set selected (
        echo "$projects" | \
        fzf \
            --border=none \
            --prompt="    " \
            --header="🔥 BLAZINGLY FAST!" \
            --header-first \
            --pointer="" \
            --scrollbar="┃" \
            --layout=reverse \
            --ansi \
            --cycle \
            --tiebreak="begin,index" \
            --scheme="path" \
            --no-mouse \
            --padding 0,0,0,1 \
            --margin 0 \
            --info=inline-right \
            --separator="r" \
            --color="border:$surface0" \
            --color="header:$maroon" \
            --color="header:bold" \
            --color="prompt:$peach" \
            --color="query:" \
            --color="info:$surface1" \
            --color="fg:$subtext0" \
            --color="bg+:$base_minus_1" \
            --color="pointer:$lavender" \
            --color="fg+:$lavender" \
            --color="fg+:bold" \
            --color="preview-bg:$base" \
            --color="preview-fg:$overlay2" \
            --color="hl:green" \
            --color="hl:bold" \
            --color="hl:underline" \
            --color="hl+:green" \
            --color="hl+:bold" \
            --color="hl+:underline" \
            --color="gutter:$mantle" \
            --color="scrollbar:green" \
            --color="scrollbar:bold" \
            --color="spinner:green" \
            --color="spinner:dim" \
            --preview="$HOME/.local/bin/scripts/mts-show-project '{}'" \
            --preview-window=border-left,60% \
            --preview-window=border-sharp
    )

    if test $status -ne 0
        return
    end

    set selected (
        echo "$selected" | \
        sed -E "s|^.{1,2} (\S+)/|projects/\1/|g" | \
        sed -E "s|^🟢 |projects/personal/|g" | \
        sed -E "s|^.{1,2}  forks|forks|g" | \
        sed -E "s|^.{1,2}  study|study|g"
    )

    set selected_dir "$HOME/$selected"

    if string match -q "*projects/*" "$selected_dir"
        set selected_name (echo "$selected" | sed -E "s|projects/||" | tr . _)
    else
        set selected_name (basename "$selected_dir" | tr . _)
    end

    if not tmux has-session -t $selected_name 2>/dev/null
        set -l tmux_python_venv
        if test -e "$selected_dir/.venv/bin/activate"
            set tmux_python_venv "$selected_dir/.venv/bin/activate"
        end

        tmux new-session -ds $selected_name -c $selected_dir \
            -x 300 -y 300 -n nvim \
            -e TMUX_PYTHON_VENV="$tmux_python_venv" \
            # source $HOME/.config/fish/config.fish && nvim .
            # && zsh
            $HOME/.local/bin/scripts/tmux-launch-nvim

        tmux new-window -t $selected_name:2 -d -c $selected_dir fish
    end

    tmux switch-client -t $selected_name
end

abbr -a sp project_selector
