#!/bin/bash

################################################################################
# Script: installation.sh
# Description: This script clones a Git repository containing shell configuration
#              files and adds a script to the user's .bashrc file to source all
#              .sh files inside a specified folder (`shell`) recursively. The
#              repository name and GitHub username are variables in the script.
# Author: Agustin Wet
# Date:   29/05/2024
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
    clone_repo
    append_to_bashrc
    source "$HOME/.bashrc" # Source the .bashrc file to apply changes immediately
    echo "Installation complete."
}

# Clone the Git repository and check if the clone was successful
clone_repo() {
    git clone "$REPO_URL" "$CLONE_DIR"
    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository."
        exit 1
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

# Append content to .bashrc if not already present
append_to_bashrc() {
    local FILE_TO_SOURCE="$CLONE_DIR/installation/source_shell_install_script.sh"

    # Ensure the file and folder exists
    if [ ! -f "$FILE_TO_SOURCE" ]; then
        echo "Function file not found: $FILE_TO_SOURCE"
        return 1
    fi

    if [ ! -d "$SHELL_DIR" ]; then
        echo "Folder to source not found: $SHELL_DIR"
        return 1
    fi

    # Build the line
    local bashrc_line="source $FILE_TO_SOURCE && source_all_sh_files $SHELL_DIR"

    lines_to_append=(
        "$bashrc_line"
        "set_prompt"
    )

    append_lines_to_bashrc "${lines_to_append[@]}"
}

# Execute the installation procedure
installation_procedure