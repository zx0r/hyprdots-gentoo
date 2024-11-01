##https://github.com/junegunn/fzf/blob/master/ADVANCED.md#switching-between-ripgrep-mode-and-fzf-mode-using-a-single-key-binding
##https://junegunn.github.io/fzf/reference/
##https://vitormv.github.io/fzf-themes/
##https://github.com/junegunn/tmux-fzf-url
##https://github.com/junegunn/tmux-fzf-maccy
#
##[center|top|bottom|left|right][,SIZE[%]][,SIZE[%]]
### 100% width and 60% height
##fzf --tmux 100%,60% --border horizontal
#
## On the right (50% width)
##fzf --tmux right
## On the left (40% width and 70% height)
##fzf --tmux left,40%,70%
#
#:
#function fzf_ripgrep_mode --description "Switch between Ripgrep launcher mode (CTRL-R) and fzf filtering mode (CTRL-F)"
#
#    rm -f /tmp/rg-fzf-{r,f}
#    set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case"
#    set INITIAL_QUERY "$argv"
#
#    fzf --ansi --disabled --query "$INITIAL_QUERY" \
#        --bind "start:reload($RG_PREFIX {q})+unbind(ctrl-r)" \
#        --bind "change:reload:sleep 0.1
#        $RG_PREFIX {q} || true" \
#        --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
#        --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
#        --color "hl:-1:underline,hl+:-1:underline:reverse" \
#        --prompt '1. ripgrep> ' \
#        --delimiter : \
#        --header '╱ CTRL-R (ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
#        --preview 'bat --color=always {1} --highlight-line {2}' \
#        --preview-window 'right,border-left,<30(up,30%,border-bottom)' \
#        --bind 'enter:become(vim {1} +{2})'
#end
#
#function rgf
#    set -l reload 'reload:rg --column --color=always --smart-case {q} || :'
#    set -l edit 'if test $FZF_SELECT_COUNT -eq 0
#                      nvim {1} +{2}   # No selection. Open the current line in Neovim.
#                  else
#                      nvim +cw -q {+f} # Build quickfix list for the selected items.
#                  end'
#
#    rg --column --color=always --smart-case "$argv" | fzf --disabled --ansi --multi \
#        --bind "start:$reload" --bind "change:$reload" \
#        --bind "enter:become:$edit" \
#        --bind "ctrl-o:execute:$edit" \
#        --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
#        --delimiter : \
#        --preview 'bat --style=full --color=always {1} || echo "No file selected"' \
#        --preview-window '~4,+{2}+4/3,<80(up)' \
#        --header 'Search results for: $argv'
#end
#
## rg --line-number --with-filename . --color=always --field-match-separator ' '\
##   | fzf --preview "bat --color=always {1} --highlight-line {2}" \
##   --preview-window ~8,+{2}-5
##
#
#function rgs
#    set file (rg --color=always --line-number --no-heading --smart-case "$argv" | fzf -d ':' \
#        --preview 'bat --style=numbers --color=always (echo {1} | cut -d: -f1) --highlight-line {2} --line-range={2}:+20' \
#        --preview-window='50%' --height='50%' --with-nth 1,3.. --exact)
#
#    # Extract the file path from the output
#    set file (string split ':' -- $file)[1]
#
#    if test -z "$file"
#        return 1 # Exit if no file is selected
#    end
#
#    exec nvim "$file" # Open the file in Neovim
#end
#
#function fzf_toggle_fd --description "Switches between two modes (Files and Directories) with a single key binding using fzf"
#    fd --type file | fzf --prompt 'Files> ' \
#        --header 'CTRL-T: Switch between Files/Directories' \
#        --bind "ctrl-t:transform[if test (string match -r 'Files' -- \$FZF_PROMPT); echo 'change-prompt(Directories> )+reload(fd --type directory)'; else; echo 'change-prompt(Files> )+reload(fd --type file)'; end]" \
#        --preview "if test (string match -r 'Files' -- \$FZF_PROMPT)
#    bat --color=always {}
# else; tree -C {}
#end"
#end
#
#
#function fzf_kill_process --description "Kill process with fzf"
#
#    # Store the output of date and ps in a variable
#    function process_list
#        date
#        ps -ef
#    end
#
#    # Run fzf to search through the process list
#    process_list | fzf \
#        --ansi \
#        --bind "ctrl-r:reload$process_list" \
#        --header 'Press CTRL-R to reload list running processes' --header-lines=2 \
#        --preview 'echo {}' --preview-window=down,3,wrap \
#        --layout reverse --height=80% \
#        --delimiter ' ' | awk '{print $2}' | xargs -r pkill -9
#end
#
#abbr -a kp fzf_kill_process
