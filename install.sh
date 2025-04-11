#!/bin/bash

################################################################################
# Description: This script clones a Git repository containing shell configuration
#              files and adds a script to the user's .bashrc file to source all
#              .sh files inside a specified folder (`shell`) recursively. The
#              repository name and GitHub username are variables in the script.
#
# Author        :   Agustin Wet
# Creation date :   29/05/2024
# Last Update   :   11/04/2025
################################################################################

# Change to the user's home directory
cd "$HOME"

# Variables
GITHUB_USERNAME="wet333"
REPO_NAME="dotfiles"
REPO_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
CLONE_DIR="$HOME/$REPO_NAME"
SHELL_DIR="$CLONE_DIR/shell"

# Main installation procedure function
installation_procedure() {
    # Initial setup
    update_and_upgrade
    clone_repo

    # System configuration
    append_to_bashrc
    add_bin_folder_to_path "$CLONE_DIR/bin"

    echo "Please stay at the desk, you will need to enter some input!!!"

    # System setup scripts
    bash "$CLONE_DIR/installation/setup_custom_filesystem.sh"
    bash "$CLONE_DIR/installation/setup_install_basic.sh"
    bash "$CLONE_DIR/installation/setup_install_asm.sh"
    bash "$CLONE_DIR/installation/setup_install_java.sh"
    bash "$CLONE_DIR/installation/setup_ssh.sh"

    # Source the .bashrc file to apply changes immediately
    source "$HOME/.bashrc"
    echo "Installation complete."
}

update_and_upgrade() {
    sudo apt update
    sudo apt upgrade -y
}

# Clone the Git repository and check if the clone was successful
clone_repo() {
    if [ -d "$CLONE_DIR" ]; then
        echo "Repository is already cloned."
    else
        echo "Cloning repository..."
        git clone "$REPO_URL" "$CLONE_DIR"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to clone repository. Aborting installation."
            exit 1
        else
            echo "Repository cloned successfully."
        fi
    fi
}

append_lines_to_bashrc() {
    local lines=("$@")

    for line in "${lines[@]}"; do
        if ! grep -Fxq "$line" ~/.bashrc; then
            echo "$line" >> ~/.bashrc
            echo "Appended to .bashrc: $line"
        else
            echo "Line already exists in .bashrc: $line"
        fi
    done
}

# Append a couple of lines into .bashrc, in order to load all configurations on each terminal session
append_to_bashrc() {
    local FILE_TO_SOURCE="$CLONE_DIR/installation/recursive_sourcing.sh"

    # Ensure the file and folder exists
    if [ ! -f "$FILE_TO_SOURCE" ]; then
        echo "Function file not found: $FILE_TO_SOURCE"
        return 1
    fi

    if [ ! -d "$SHELL_DIR" ]; then
        echo "Folder to source not found: $SHELL_DIR"
        return 1
    fi

    # Build the line that sources all .sh files in the /shell folder and subfolders
    local bashrc_line="source $FILE_TO_SOURCE && recursive_sourcing $SHELL_DIR"

    lines_to_append=(
        "$bashrc_line"
        "set_prompt"   # Prompt configuration function
    )

    append_lines_to_bashrc "${lines_to_append[@]}"
}

add_bin_folder_to_path() {
    # Verify that a directory argument is provided.
    if [ $# -eq 0 ]; then
        echo "Usage: add_bin_folder_to_path <directory>"
        return 1
    fi

    # Use a local variable to hold the directory path.
    local directory="$1"

    # If the directory does not exist, try to create it.
    if [ ! -d "$directory" ]; then
        echo "Directory '$directory' does not exist. Creating it..."
        mkdir -p "$directory"
        # Check that mkdir succeeded.
        if [ $? -ne 0 ]; then
            echo "Failed to create '$directory'. Please check your permissions."
            return 1
        fi
    fi

    # Check if the directory is already in the PATH.
    if [[ ":$PATH:" == *":$directory:"* ]]; then
        echo "'$directory' is already in PATH."
        return 0
    fi

    # Append the export command to ~/.bashrc
    {
        echo ""
        echo "export PATH=\$PATH:$directory"
    } >> ~/.bashrc

    # Optionally, update the current shell's PATH.
    export PATH="$PATH:$directory"

    echo "Added '$directory' to PATH. The change has been applied to the current session and will persist in new terminals."
}


# Execute the installation procedure
installation_procedure