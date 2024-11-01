##!/usr/bin/env fish
## https://github.com/amaya382/zsh-fzf-widgets/blob/master/zsh-fzf-widgets.zsh
#
## Check if FZF_CMD, FZF_PASTE_KEY, and FZF_EXEC_KEY are set, else set default values
#set FZF_CMD "fzf --ansi"
#set FZF_PASTE_KEY tab
#set FZF_EXEC_KEY enter
#
#set FZF_DEFAULT_OPTS " \
#                --color=fg:#303138,fg+:#11ff00,bg:#000000,bg+:#262626 \
#                --color=hl:#5f87af,hl+:#677b66,info:#afaf87,marker:#ff00f7 \
#                --color=prompt:#d7005f,spinner:#af5fff,pointer:#18eb0d,header:#87afaf \
#                --color=gutter:#000000,border:#c567da,separator:#d4ff00,scrollbar:#282525 \
#                --color=label:#aeaeae,query:#d9d9d9 \
#                --walker-skip .git,node_modules,target \
#                --bind 'ctrl-d:change-preview-window(down|hidden|)' \
#                --color header:italic \
#                --header="" \
#                --height=80% \
#                --info="right" \
#                --border="rounded" \
#                --border-label="+" \
#                --prompt="➜ " \
#                --marker=" >>" \
#                --pointer=" >" \
#                --separator="." \
#                --scrollbar="." \
#                --layout="reverse-list""
#
## Function to change directories using fzf
#function fzf-cd
#    # Find directories excluding system directories and hidden files
#    set dir (find -L . -mindepth 1 \
#        \( -path '*/\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \) \
#        -prune -o -type d -print 2>/dev/null | cut -b3-  "$FZF_DEFAULT_OPTS \
#            --bind=\"$FZF_PASTE_KEY:execute:echo {}+abort\" \
#            --bind=\"$FZF_EXEC_KEY:execute:echo 'cd {}'+abort\"" fzf)
#
#    # If a directory was selected, change to it
#    if test -n "$dir"
#        commandline --insert "cd $dir"
#        eval "cd $dir" # Ensure directory change takes effect
#    end
#end
#
## Function to quickly return to recently visited directories
#function fzf-cdr
#    # List recently visited directories using `cdr`
#    set dir (cdr -l | sed 's/^[^ ][^ ]*  *//' | while read -l f
#        if test -d "$f"
#            echo "$f"
#        else
#            echo -e "\e[31m$f\e[m"
#        end
#    end | FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
#        --bind=\"$FZF_PASTE_KEY:execute:echo {}+abort\" \
#        --bind=\"$FZF_EXEC_KEY:execute:echo 'cd {}'+abort\"" fzf --ansi)
#
#    # If a directory was selected, change to it
#    if test -n "$dir"
#        commandline --insert "cd $dir"
#        eval "cd $dir" # Ensure directory change takes effect
#    end
#end
#
#function fzf-history
#    # Fetch Fish history and display in fzf
#    set res (history | fzf --query=(commandline) \
#        --tiebreak=index \
#        --bind="$FZF_PASTE_KEY:accept" \
#        --bind="$FZF_EXEC_KEY:execute:echo - (echo {} | sed -e 's/^ //') +abort" \
#        --height=40% \
#        --reverse \
#        --no-sort)
#
#    if test -n "$res"
#        set num (echo $res | awk '{print $1}')
#        if test -n "$num"
#            if test "$num" -ge 1
#                commandline --replace (history | head -n $num | string join '\n')
#            else
#                commandline --replace (history | tail -n (math -$num) | string join '\n')
#                commandline --accept
#            end
#        end
#    end
#end
#
#
#function fzf-git-checkout
#    # Checkout Git branches interactively using fzf
#    if git status 2>/dev/null
#        set branches (git branch -a --color=always | grep -v HEAD)
#        set res (echo $branches | FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
#            --bind=\"$FZF_PASTE_KEY:execute:echo {} | sed -e 's/.* //' -e 's!remotes/[^/]*/!!'+abort\" \
#            --bind=\"$FZF_EXEC_KEY:execute:echo git checkout \$(echo {} | sed -e 's/.* //' -e 's!remotes/[^/]*/!!')+abort\"" \
#        $FZF_CMD)
#
#        if test -n "$res"
#            if string match -r '^git checkout (.+)$' "$res"
#                eval $res
#            else
#                commandline --insert $res
#            end
#        end
#    end
#end
#
## Additional functions (fzf-git-log, fzf-git-status, etc.) can be adapted similarly.
##
## Function to browse and select a Git log commit using fzf
#function fzf-git-log
#    if git status >/dev/null 2>&1
#        set res (git log --graph --color=always \
#            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" \
#            | fzf --no-sort --reverse --tiebreak=index \
#                --bind="$FZF_PASTE_KEY:execute(echo {} | grep -o '[a-f0-9]\{7\}' | head -1)+abort" \
#                --bind="$FZF_EXEC_KEY:execute(git show --color=always (echo {} | grep -o '[a-f0-9]\{7\}' | head -1) | less -R)+abort")
#        if test -n "$res"
#            commandline --insert $res
#        end
#    end
#end
#
## Function to browse Git status with fzf and display file diffs
#function fzf-git-status
#    if git status >/dev/null 2>&1
#        set res (git -c color.status=always status -s \
#            | fzf --no-sort --reverse \
#                --bind="$FZF_PASTE_KEY:execute(echo {} | sed -e 's/^...//')+abort" \
#                --bind="$FZF_EXEC_KEY:execute(
#                    set f (echo {} | sed -e 's/^...//');
#                    set mark (echo {} | string match -r '^..');
#                    switch $mark
#                        case RM
#                            echo $f; git diff --color=always (echo $f | sed -e 's/^.* -> //') | less -R
#                        case R\?
#                            echo $f
#                        case M\?
#                            git diff --color=always --cached $f | less -R
#                        case ?M
#                            git diff --color=always $f | less -R
#                        case A\? \?D
#                            git diff HEAD --color=always -- $f | less -R
#                        case \\?\\?
#                            cat $f | less -R
#                    end)+abort")
#        if test -n "$res"
#            commandline --insert $res
#        end
#    end
#end
#
## Function to kill processes interactively
#function fzf-kill-proc-by-list
#    set cmd (if test "$UID" != 0
#                echo "ps -f -u $UID"
#              else
#                echo "ps -ef"
#              end)
#
#    set res (eval $cmd | fzf --no-sort --reverse \
#        --bind="$FZF_PASTE_KEY:execute(echo {} | awk '{print \$2}')+abort" \
#        --bind="$FZF_EXEC_KEY:execute(kill -9 (echo {} | awk '{print \$2}'))+abort")
#
#    if test -n "$res"
#        commandline --insert "$res"
#    end
#end
#
## Function to kill processes by port interactively using fzf
#function fzf-kill-proc-by-port
#    set res (sudo ss -natup | fzf --query='' --no-sort --reverse \
#        --bind="$FZF_PASTE_KEY:execute(grep -oP '(?<=pid=)\\d+(?=,)' {})+abort" \
#        --bind="$FZF_EXEC_KEY:execute(sudo kill -9 (grep -oP '(?<=pid=)\\d+(?=,)' {})) +abort")
#
#    if test -n "$res"
#        commandline --insert "$res"
#    end
#end
#
## Function to select gitmoji interactively using fzf
#function fzf-gitmoji
#    set res (gitmoji -l | fzf --bind="$FZF_PASTE_KEY:accept" | grep -oP ':.+:')
#
#    if test -n "$res"
#        commandline --insert "$res"
#    end
#end
