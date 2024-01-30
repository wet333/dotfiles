#!/bin/bash

# Check if the argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <toggle>"
    echo "Example: $0 on"
    exit 1
fi

# Function to toggle hidden files visibility
toggle_hidden_files() {
    if [ "$1" = "on" ]; then
        kwriteconfig5 --file ~/.config/kiorc --group "KDE" --key "ShowHiddenFiles" true
        echo "Hidden files are now visible."
    elif [ "$1" = "off" ]; then
        kwriteconfig5 --file ~/.config/kiorc --group "KDE" --key "ShowHiddenFiles" false
        echo "Hidden files are now hidden."
    else
        echo "Invalid argument. Please use 'on' or 'off'."
        exit 1
    fi
}

# Toggle hidden files visibility
toggle_hidden_files "$1"
