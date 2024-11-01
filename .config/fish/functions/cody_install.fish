function cody
    if test (count $argv) -eq 0
        echo "Usage: cody <command> [options]"
        echo "Commands:"
        echo "  auth                   Authenticate Cody with Sourcegraph"
        echo "  chat <message>         Chat with codebase context"
        echo "  file <file> <message>  Chat about a specific file"
        echo "  diff <message>         Explain the current git diff"
        echo "  repo <repo> <message>  Chat about a specific repository (Enterprise only)"
        echo "  help                   Display help for a command"
        return 1
    end

    switch $argv[1]
        case auth
            command cody auth

        case chat
            if test (count $argv) -lt 2
                echo "Usage: cody chat <message>"
                return 1
            end
            command cody chat -m "$argv[2..-1]"

        case file
            if test (count $argv) -lt 3
                echo "Usage: cody file <file> <message>"
                return 1
            end
            command cody chat --context-file $argv[2] --message "$argv[3..-1]"

        case diff
            if test (count $argv) -lt 2
                echo "Usage: cody diff <message>"
                return 1
            end
            git diff | command cody chat --stdin -m "$argv[2..-1]"

        case repo
            if test (count $argv) -lt 3
                echo "Usage: cody repo <repo> <message>"
                return 1
            end
            command cody chat --context-repo $argv[2] --message "$argv[3..-1]"

        case help
            if test (count $argv) -eq 1
                command cody --help
            else
                command cody help $argv[2]
            end

        case '*'
            echo "Unknown command: $argv[1]"
            echo "Run 'cody help' for usage information."
            return 1
    end
end

function install_cody
    echo "Installing Cody CLI..."
    if not npm install -g @sourcegraph/cody
        echo "Failed to install Cody CLI. Please check your npm configuration and try again."
        return 1
    end
    echo "Cody CLI installed successfully!"

    echo "Authenticating with Cody..."
    if not cody auth login
        echo "Authentication failed. Error code: $status"
        echo "Here are some steps to resolve the issue:"
        echo "1. Ensure you have a valid Sourcegraph access token."
        echo "2. Check your internet connection."
        echo "3. Verify that your Sourcegraph instance URL is correct."
        echo "4. Make sure you're using the latest version of Cody CLI."
        echo "5. Try setting the SRC_ENDPOINT and SRC_ACCESS_TOKEN environment variables:"
        echo "   set -x SRC_ENDPOINT https://sourcegraph.com"
        echo "   set -x SRC_ACCESS_TOKEN <your_access_token_here>"
        echo "6. If the problem persists, try uninstalling and reinstalling Cody CLI:"
        echo "   npm uninstall -g @sourcegraph/cody"
        echo "   npm install -g @sourcegraph/cody"
        echo "7. Check the Cody CLI documentation for any known issues or updates."
        echo "8. If none of the above work, please report the issue to Sourcegraph support."
        return 1
    end
    echo "Authentication successful!"

    echo "Starting initial chat with Cody..."
    if not cody chat -m Hello
        echo "Failed to start initial chat with Cody."
        return 1
    end

    if set -q argv[1]
        echo "Starting chat with user-provided message..."
        if not cody chat -m "$argv"
            echo "Failed to start chat with user-provided message."
            return 1
        end
    end

    echo "Cody installation and setup completed successfully!"
end
