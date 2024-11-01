#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

# Function to display messages
function echo_message {
  echo "[INFO] $1"
}

# Function to display usage information
function usage {
  echo "Usage: $(basename "$0") [options]"
  echo
  echo "Options:"
  echo "  -h, --help          Show this help message."
  echo "  -i, --install       Install Taskwarrior and set up configuration."
  echo "  -c, --config        Configure Taskwarrior settings."
  echo "  -d, --directories   Create necessary directories."
  echo
  echo "Examples:"
  echo "  $(basename "$0") -i"
  echo "  $(basename "$0") -c"
  echo "  $(basename "$0") -d"
  exit 0
}

# Function to install Taskwarrior
function install_taskwarrior {
  echo_message "Updating package repository..."
  sudo emerge --sync
  echo_message "Installing Taskwarrior..."
  sudo emerge app-misc/task
}

# Function to initialize Taskwarrior configuration
function init_taskwarrior {
  echo_message "Initializing Taskwarrior..."
  # Run the Taskwarrior init command
  if command -v task &>/dev/null; then
    task init
  else
    echo_message "Taskwarrior is not installed. Please install it first."
    exit 1
  fi
}

# Function to create necessary directories
function create_directories {
  echo_message "Creating configuration and data directories..."
  mkdir -p "$HOME/.config/task"
  mkdir -p "$HOME/.config/task/hooks"
  mkdir -p "$HOME/.local/share/task"
}

# Function to move taskrc to the new location
function move_taskrc {
  if [ -f "$HOME/.taskrc" ]; then
    echo_message "Moving ~/.taskrc to ~/.config/task/taskrc..."
    mv "$HOME/.taskrc" "$HOME/.config/task/taskrc"
  else
    echo_message "No existing ~/.taskrc found."
  fi
}

# Function to create and configure taskrc
function configure_taskrc {
  if [ ! -f "$HOME/.config/task/taskrc" ]; then
    echo_message "Creating default ~/.config/task/taskrc..."
    touch "$HOME/.config/task/taskrc"
  fi

  echo_message "Configuring ~/.config/task/taskrc..."
  {
    echo "data.location=$HOME/.local/share/task"
    echo "hooks.location=$HOME/.config/task/hooks"
  } >>"$HOME/.config/task/taskrc"
}

# Function to move existing task directory
function move_task_directory {
  if [ -d "$HOME/.task" ]; then
    echo_message "Copying contents of ~/.task to ~/.local/share/task..."
    cp -r "$HOME/.task/"* "$HOME/.local/share/task/"
    echo_message "Deleting original ~/.task directory..."
    rm -rf "$HOME/.task/"
  else
    echo_message "No existing ~/.task directory found."
  fi
}

# Function to copy hooks
function copy_hooks {
  if [ -d "$HOME/.task/hooks" ]; then
    echo_message "Copying hooks from ~/.task/hooks to ~/.config/task/hooks..."
    cp -r "$HOME/.task/hooks/"* "$HOME/.config/task/hooks/"
    echo_message "Deleting original ~/.task/hooks directory..."
    rm -rf "$HOME/.task/hooks/"
  else
    echo_message "No existing hooks directory found."
  fi
}

# Main function
function main {
  if [[ $# -eq 0 ]]; then
    usage
  fi

  while [[ "$#" -gt 0 ]]; do
    case $1 in
    -h | --help) usage ;;
    -i | --install)
      # install_taskwarrior
      init_taskwarrior
      create_directories
      move_taskrc
      configure_taskrc
      move_task_directory
      copy_hooks
      echo_message "Taskwarrior installation and configuration complete!"
      exit 0
      ;;
    -c | --config)
      configure_taskrc
      echo_message "Taskwarrior configuration complete!"
      exit 0
      ;;
    -d | --directories)
      create_directories
      echo_message "Directories created!"
      exit 0
      ;;
    *)
      echo "[ERROR] Unknown option: $1"
      usage
      ;;
    esac
    shift
  done
}

# Execute the main function
main "$@"
