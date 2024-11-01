#https://www.foxk.it/blog/gpg-ssh-agent-fish/
# Initialize GPG Agent and set up SSH Agent integration for GPG

# Ensure GPG Agent is used as the SSH Agent by setting SSH_AUTH_SOCK
if test -n "$SSH_AUTH_SOCK"
    set -e SSH_AUTH_SOCK
end

# Set SSH_AUTH_SOCK to the GPG Agent socket location, making it accessible to other tools
set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# Set GPG_TTY to the current terminal for proper pinentry handling
set -x GPG_TTY (tty)

# Launch GPG Agent to ensure it's running
gpgconf --launch gpg-agent
