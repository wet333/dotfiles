#!/bin/bash

# Script to create folders based on the list, inside the ~/Documents directory
# This helps to unify organization of files and custom system functionality

# Directory Lists
main_folder="Files"
folders_to_create=("Downloads" "Images" "Music" "Programming" "Docs")
folders_to_delete=("Downloads" "Music" "Pictures" "Videos" "Templates" "Public" "Documents")

# Init Configuration
DELETE_FOLDERS=true

# Functions ------------------------------------------------------------------------------------------------------------
fs_init() {
    create_folders

    if $DELETE_FOLDERS; then
        delete_folders
    else
        echo "Delete operation skipped. To delete default directories, Set DELETE_FOLDERS to true."
    fi
}

create_folders() {
    for folder in "${folders_to_create[@]}"; do
        mkdir -p ~/"$main_folder"/"$folder"
    done
    echo "Folders created successfully."
}

delete_folders() {
    for folder in "${folders_to_delete[@]}"; do
        rm -rf ~/"$folder"
    done
    echo "Folders deleted successfully."
}
# ----------------------------------------------------------------------------------------------------------------------

fs_init  # Execute script