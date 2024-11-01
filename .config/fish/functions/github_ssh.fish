function setup_github_ssh --description "Set up SSH access to GitHub"

    set -l github_email "your_email@example.com"

    # Step 1: Check for existing SSH keys
    if test -f ~/.ssh/id_ed25519.pub
        echo "🔑 SSH key already exists. Skipping key generation."
    else
        # Step 2: Generate a new SSH key if none found
        echo "🔧 Generating new SSH key..."
        ssh-keygen -t ed25519 -C $github_email
    end

    # Step 3: Start SSH agent and add the key
    echo "🚀 Starting SSH agent and adding key..."
    eval (ssh-agent -c)
    ssh-add ~/.ssh/id_ed25519

    # Step 4: Display and copy SSH key to clipboard
    echo "📋 Copying SSH key to clipboard..."
    if type -q xclip
        cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
        echo "✅ SSH key copied to clipboard. Add it to GitHub SSH keys https://github.com/settings/keys"
    else
        echo "⚠️ xclip not found. Please copy manually:"
        cat ~/.ssh/id_ed25519.pub
    end

    # Step 5: Test connection to GitHub
    echo "🔍 Testing SSH connection to GitHub..."
    ssh -T git@github.com
    if test $status -eq 1
        echo "✅ Connection successful. GitHub does not provide shell access, but you are authenticated."
    else
        echo "⚠️ Connection failed. Please verify your GitHub SSH settings."
    end
end
