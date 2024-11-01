function fzf_dev

    # Keybinding Explanations:
    # C-?: Toggles the preview pane to show or hide additional content for the selected item.
    # C-a: Selects all items or toggles the selection of all items for batch actions.
    # C-b: Uses bat to preview files, offering enhanced display features.
    # A-e: Opens the selected file in your configured text editor for quick editing.
    # C-v: Launches Visual Studio Code with the selected file for a seamless workflow.
    # C-s: Toggles the sort order of the displayed items.
    # A-p: Allows navigation through the preview pane.
    # C-k: Similar to Alt-p, it lets you navigate up the preview items.
    # C-u: Scrolls the preview pane half a page up or down for better navigation.
    # change:top: Moves the cursor to the top of the list.
    # C-y: Copies the selected item to the clipboard without displaying a message.

    # Define color variables
    set -g color_fg '#303138'
    set -g color_fg_plus '#11ff00'
    set -g color_bg '#000000'
    set -g color_bg_plus '#262626'
    set -g color_hl '#5f87af'
    set -g color_hl_plus '#677b66'
    set -g color_info '#afaf87'
    set -g color_marker '#ff00f7'
    set -g color_prompt '#d7005f'
    set -g color_spinner '#c567da'
    set -g color_pointer '#18eb0d'
    set -g color_header '#87afaf'
    set -g color_gutter '#000000'
    set -g color_border '#c567da'
    set -g color_separator '#d4ff00'
    set -g color_scrollbar '#282525'
    set -g color_label '#aeaeae'
    set -g color_query '#d9d9d9'


    # Set the FZF command
    set -gx FZF_DEFAULT_COMMAND_AG "ag --hidden --ignore .git --ignore .sass-cache --ignore node_modules -g ''"
    # set -gx FZF_DEFAULT_COMMAND_FD "fd --no-ignore --hidden --follow --color=always --strip-cwd-prefix --exclude '.git' --type d -d 1 | lscolors"
    # set -gx FZF_DEFAULT_COMMAND_RG "rg --files --hidden --glob '!{*.git/**,!node_modules,!build/**,!dart_tool/**,!idea}'"

    # FZF Configuration for Fish Shell
    set -gx FZF_FILE_PREVIEW "bat --map-syntax=.ignore:Git --theme=Dracula --style=grid --color=always --decorations=always --line-range :500 {}"
    set -gx FZF_DIR_PREVIEW "eza --tree --level=2 --color=always --group-directories-first --icons=auto --hyperlink -snew {} | head -200"
    set -gx FZF_BIN_PREVIEW "if test (file --mime-type -b {}) = "application/octet-stream"; echo "{} is a binary file"; end"

    set -gx FZF_DEFAULT_OPTS ' \
        --color=fg:$color_fg,fg+:$color_fg_plus,bg:$color_bg,bg+:$color_bg_plus \
        --color=hl:$color_hl,hl+:$color_hl_plus,info:$color_info,marker:$color_marker \
        --color=prompt:$color_prompt,spinner:$color_spinner,pointer:$color_pointer,header:$color_header \
        --color=gutter:$color_gutter,border:$color_border,separator:$color_separator,scrollbar:$color_scrollbar \
        --color=label:$color_label,query:$color_query --color header:italic \
        --ansi \
        --cycle \
        --multi \
        --tabstop=4 \
        --height=80% \
        --highlight-line \
        --info=inline-right \
        --layout="reverse-list" \
        --border="rounded" \
        --border-label="❱❱ fzf search code/files/dir/bin ❱❱" \
        --preview-window="border-rounded" \
        --border-label-pos="-5" \
        --padding="1" --margin="0" \
        --prompt="➜ " --marker="❱❱" --pointer="➤ " \
        --separator="" --scrollbar=""'

    #     --jump-labels='abcdefghijklmnopqrstuvwxyz'
    #     --bind='esc:abort'
    #     --bind='ctrl-c:abort'
    #     --bind='ctrl-q:abort'
    #     --bind='ctrl-g:cancel'
    #     --bind='ctrl-j:down'
    #     --bind='ctrl-k:up'
    #     --bind='home:beginning-of-line'
    #     --bind='end:end-of-line'
    #     --bind='ctrl-s:beginning-of-line'
    #     --bind='ctrl-e:end-of-line'
    #     --bind='alt-x:unix-line-discard'
    #     --bind='alt-c:unix-word-rubout'
    #     --bind='alt-d:kill-word'
    #     --bind='ctrl-h:backward-delete-char'
    #     --bind='alt-bs:backward-kill-word'
    #     --bind='ctrl-w:backward-kill-word'
    #     --bind='alt-a:toggle-all'
    #     --bind='ctrl-alt-a:toggle-all+accept'
    #     --bind='alt-s:toggle-sort'
    #     --bind='ctrl-P:clear-selection'
    #     --bind='page-up:prev-history'
    #     --bind='page-down:next-history'
    #     --bind='alt-{:prev-history'
    #     --bind='alt-}:next-history'
    #     --bind='alt-shift-up:prev-history'
    #     --bind='alt-shift-down:next-history'
    #     --bind='alt-left:first'
    #     --bind='alt-right:last'
    #     --bind='alt-up:prev-selected'
    #     --bind='alt-down:next-selected'
    #     --bind='ctrl-u:half-page-up'
    #     --bind='ctrl-d:half-page-down'
    #     --bind='ctrl-alt-u:page-up'
    #     --bind='ctrl-alt-d:page-down'
    #     --bind='alt-enter:replace-query+print-query'
    #     --bind='ctrl-/:jump'
    #     --bind='?:toggle-preview'
    #     --bind='alt-[:toggle-preview'
    #     --bind='alt-]:change-preview-window(70%|45%,down,border-top|45%,up,border-bottom|)+show-preview'
    #     --bind='alt-w:toggle-preview-wrap'
    #     --bind='ctrl-b:preview-page-up'
    #     --bind='ctrl-f:preview-page-down'
    #     --bind='alt-i:preview-page-up'
    #     --bind='alt-o:preview-page-down'
    #     --bind='ctrl-alt-b:preview-up'
    #     --bind='ctrl-alt-f:preview-down'
    #     --bind='alt-e:become($EDITOR {+})'
    #     --bind='alt-b:become(bat --paging=always -f {+})'
    #     --bind='ctrl-y:execute-silent(xsel --trim -b <<< {+})'
    #     --bind='ctrl-]:preview(bat --color=always -l bash \"$XDG_DATA_HOME/gkeys/fzf\")'
    #     --bind='alt-/:unbind(?)'
    #     --bind='ctrl-\\:rebind(?)'
    #     --bind='f2:unbind(?)'
    #     --bind='f3:rebind(?)'
    #     --bind='change:first'"

    # # --bind='?:toggle-preview'
    # # --bind='ctrl-a:select-all,ctrl-r:toggle-all'
    # # --bind='ctrl-b:execute(bat --paging=always -f {+})'
    # # --bind='alt-e:execute($EDITOR {} >/dev/tty </dev/tty)' 
    # # --bind='ctrl-v:execute(code {+})'           
    # # --bind='ctrl-s:toggle-sort'                  
    # # --bind='alt-p:preview-up,alt-n:preview-down'
    # # --bind='ctrl-k:preview-up,ctrl-j:preview-down' 
    # # --bind='ctrl-u:half-page-up,ctrl-d:half-page-down' 
    # # --bind='change:top'                         
    # # --bind 'ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)' 
    # # "

    # # Set FZF preview options
    # set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --preview '$fzf_preview_dir {2}'"


    # Set FZF preview options
    # set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS $FZF_DEFAULT_COMMAND --preview=\"($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null\" {2}'"
    #
    # nvim (fd . $XDG_CONFIG_HOME --type f | fzf \
    # --preview "bat --map-syntax=.ignore:Git --theme=GitHub --style=plain --color=always --decorations=always --line-range :500 {}")



end


#https://vitormv.github.io/fzf-themes/
#https://github.com/junegunn/fzf/blob/master/README.md
# https://github.com/DanielFGray/fzf-scripts
# https://github.com/junegunn/fzf/wiki/Related-project
# https://github.com/kazhala/dotbare?
#https://github.com/junegunn/fzf/blob/master/ADVANCED.md#switching-between-ripgrep-mode-and-fzf-mode-using-a-single-key-binding
# FZF

# function e --description "Edit config file im the $XDG_CONFIG_HOME"
#     #
#     #--prompt '∷ ' \
#
#     nvim (fd . $XDG_CONFIG_HOME --type f | fzf \
#                 --color=fg:#303138,fg+:#11ff00,bg:#000000,bg+:#262626 \
#                 --color=hl:#5f87af,hl+:#677b66,info:#afaf87,marker:#ff00f7 \
#                 --color=prompt:#d7005f,spinner:#af5fff,pointer:#18eb0d,header:#87afaf \
#                 --color=gutter:#000000,border:#c567da,separator:#d4ff00,scrollbar:#282525 \
#                 --color=label:#aeaeae,query:#d9d9d9 \
#                 --walker-skip .git,node_modules,target \
#                 --bind 'ctrl-d:change-preview-window(down|hidden|)' \
#                 --color header:italic \
#                 --height=80% \
#                 --info="right" \
#                 --border="rounded" \
#                 --border-label="+" \
#                 --separator="." \
#                 --preview "bat --map-syntax=.ignore:Git --theme=GitHub --style=grid --color=always --decorations=always --line-range :500 {}")
# end
#
#
# function edit
#     nvim (set -l FZF_DEFAULT_COMMAND 'fd'; set -l FZF_DEFAULT_OPTS "--preview 'bat --style=numbers --color=always --line-range :500 {}'"; fzf --height 60% --border="rounded" --preview-window="border-rounded" --prompt="➜" \
#         --marker=">>" --pointer=">" --separator="." \
#         --layout="reverse-list" --info="right")
# end
# #
# Work
# set -gx FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
#     --color=fg:#5b5d5e,fg+:#2aff00,bg:#000000,bg+:#000000 \
#     --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#001cba \
#     --color=prompt:#d7005f,spinner:#9dff00,pointer:#48ff00,header:#87afaf \
#     --color=border:#d000ff,separator:#95ff00,label:#aeaeae,query:#d9d9d9 \
#
#     set -gx FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS' \
# --color=fg:#5b5d5e,fg+:#2aff00,bg:#000000,bg+:#000000 \
# --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#001cba \
# --color=prompt:#d7005f,spinner:#9dff00,pointer:#48ff00,header:#87afaf \
# --color=border:#d000ff,separator:#95ff00,label:#aeaeae,query:#d9d9d9 \
# --border="rounded" --border-label="❱❱ fzf search dir/files/byn ❰❰ " \
# --border-label-pos="-5" --preview-window="border-rounded" \
# --padding="1" --margin="1" --prompt="➜ " --marker="❱❱" \
# --pointer="➤ " --separator="⋆" --scrollbar=""'
