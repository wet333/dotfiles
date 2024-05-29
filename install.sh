#!/bin/bash

################################################################################
# Script: install.sh
# Description: This script clones a Git repository containing shell configuration
#              files and adds a script to the user's .bashrc file to source all
#              .sh files inside a specified folder (`shell`) recursively. The
#              repository name and GitHub username are variables in the script.
# Author: Your Name
# Date: Insert Date
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

# Append content to .bashrc if not already present
append_to_bashrc() {
    local content="$BASHRC_LOADER"
    local bashrc="$HOME/.bashrc"

    if ! grep -Fq "$content" "$bashrc"; then
        echo "$content" >> "$bashrc"
        echo "Appended content to $bashrc"
    else
        echo "Content already present in $bashrc"
    fi
}

# Define the function to source .sh files recursively
BASHRC_LOADER=$(cat <<'EOF'
# Source all .sh files in the shell folder recursively
source_all_sh_files() {
    local dir="$1"
    for file in "$dir"/*.sh; do
        if [ -f "$file" ]; then
            . "$file"
        fi
    done
    for subdir in "$dir"/*; do
        if [ -d "$subdir"]; then
            source_all_sh_files "$subdir"
        fi
    done
}

# Call the function with the specific directory
source_all_sh_files "$SHELL_DIR"
EOF
)

# Replace placeholder with actual repository name
BASHRC_LOADER="${BASHRC_LOADER//REPO_NAME/$REPO_NAME}"

# Execute the installation procedure
installation_procedure