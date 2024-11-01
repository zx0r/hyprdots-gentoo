function config --wraps='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' --description 'alias config /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv

end

function ctm --wraps='commit -a -u -m' --description 'alias ctm commit -a -u -m'
    commit -a -u -m $argv

end
