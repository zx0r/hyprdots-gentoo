function tmux_create_session
    set session_name DEV
    set window_names Dev Git Ext
    set number_of_panels 1
    set layout even-horizontal # Change to your preferred layout (tiled, even-horizontal, even-vertical, main-horizontal, main-vertical)

    # Check if the session already exists
    tmux has-session -t $session_name 2>/dev/null
    if [ $status -eq 0 ]
        echo "Tmux session '$session_name' already exists."
        return
    end

    # Create a new Tmux session
    tmux new-session -d -s $session_name -n $window_names[1]

    # Create windows and setup panes
    for window in $window_names
        if test "$window" != "$window_names[1]"
            tmux new-window -t $session_name -n $window
        end

        # Create specified number of panes
        for i in (seq $number_of_panels)
            tmux split-window -h # Split horizontally
        end

        # Run 'cmatrix' in each pane
        # tmux select-window -t $session_name:$window
        # for i in (seq $number_of_panels)
        #     tmux select-pane -t $i
        #     tmux send-keys cmatrix C-m
        # end
    end

    # Set the layout of the panes
    # tmux select-window -t $session_name:1
    tmux select-layout $layout

    # Attach to the session
    tmux attach-session -t $session_name

    # Prefix key (usually Ctrl+b)
    # set -g prefix C-a

    # Key binding to switch between sessions
    # bind s choose-session # Press prefix + s to choose a session
    #
    # # Key bindings to navigate between windows
    # bind -n M-Left previous-window # Alt + Left Arrow to switch to the previous window
    # bind -n M-Right next-window # Alt + Right Arrow to switch to the next window
    #
    # # Key bindings for window navigation using numbers
    # bind -n C-1 select-window -t :1 # Ctrl + 1 to switch to window 1
    # bind -n C-2 select-window -t :2 # Ctrl + 2 to switch to window 2
    # bind -n C-3 select-window -t :3 # Ctrl + 3 to switch to window 3

end
