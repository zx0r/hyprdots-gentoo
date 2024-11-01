# function fm
#
#     foot \
#         -e \
#         lf $(command fd -Hi -td \
#               | fzf \
#               --color=fg:#303138,fg+:#11ff00,bg:#000000,bg+:#262626 \
#               --color=hl:#5f87af,hl+:#677b66,info:#afaf87,marker:#ff00f7 \
#               --color=prompt:#d7005f,spinner:#af5fff,pointer:#18eb0d,header:#87afaf \
#               --color=gutter:#000000,border:#c567da,separator:#d4ff00,scrollbar:#282525 \
#               --color=label:#aeaeae,query:#d9d9d9 \
#               --walker-skip .git,node_modules,target \
#               --color header:italic \
#               --header="Press CTRL-D Edit config file im the $XDG_CONFIG_HOME" \
#               --height=80% \
#               --info="right" \
#               --border="rounded" \
#               --border-label="+" \
#               --prompt="➜ " \
#               --marker=">>" \
#               --pointer=">" \
#               --separator="." \
#               --layout="reverse-list" \
#               --no-info \
#               --preview 'eza --tree --level=2 --color=always --group-directories-first --icons=auto -snew {} | head -200' $argv)
#     # vim: ft=sh:et:sw=2:ts=2:sts=0:fdm=marker:fmr={{{,}}}:
# end
