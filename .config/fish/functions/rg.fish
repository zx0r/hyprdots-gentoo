function Rg
    rg --column --line-number --no-heading --color=always --smart-case "$argv" |
        fzf --ansi \
            --delimiter : \
            --bind 'ctrl-e:become($EDITOR (echo {} | hck -d: -f1))' \
            --preview 'bat --style=numbers,header,changes,snip --color=always --highlight-line {2} -- {1}' \
            --preview-window 'default:right:60%:~1:+{2}+3/2:border-left'
end

# Version 1: Use skim (sk) to find files with enhanced preview
function Sk
    sk --ansi \
        --prompt '❱ ' \
        --cmd-prompt '❱ ' \
        --interactive \
        --delimiter : \
        --bind 'ctrl-e:execute($EDITOR (echo {} | hck -d: -f1) >/dev/tty </dev/tty)' \
        --preview 'bat --style=numbers,header,changes,snip --color=always --highlight-line {2} -- {1}' \
        --preview-window 'default:right:60%:~1:+{2}+3/2:border-left' \
        --cmd 'rg --column --line-number --no-heading --color=always --smart-case "{}"' \
        --cmd-query "$argv"
end

# Version 2: Use ripgrep with custom function rgu for finding files
function RG
    rgu $argv
end

# Find TODO comments in the codebase
function TODOS
    set RG_PREFIX "rg --column --hidden --line-number --no-heading --color=always --smart-case \
    '\\bFIXME\\b|\\bFIX\\b|\\bDISCOVER\\b|\\bNOTE\\b|\\bNOTES\\b|\\bINFO\\b|\\bOPTIMIZE\\b|\\bXXX\\b|\\bEXPLAIN\\b|\\bTODO\\b|\\bHACK\\b|\\bBUG\\b|\\bBUGS\\b'"

    set selected (fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --disabled \
        --delimiter : \
        --bind 'ctrl-e:execute($EDITOR (echo {} | hck -d: -f1) >/dev/tty </dev/tty)' \
        --bind 'ctrl-y:execute-silent(echo {+} | hck -d: -f1 | xsel -b)' \
        --preview 'bat --style=numbers,header,changes,snip --color=always --highlight-line {2} -- {1}' \
        --preview-window 'default:right:60%:~1:+{2}+3/2:border-left')

    set selected (string split ":" $selected)
    if test -n "$selected[1]"
        $EDITOR "+$selected[2]" -- "$selected[1]"
    end
end
