#!/bin/bash

# Script to create folders based on the list, inside the ~/Documents directory
# This helps to unify organization of files and custom system functionality

# Directory Lists
main_folder="Files"
folders_to_create=("Downloads" "Music" "Pictures" "Videos" "Programming" "Documents")
folders_to_delete=("Downloads" "Music" "Pictures" "Videos" "Documents" "Templates" "Public")

# Init Configuration
DELETE_FOLDERS=true

# Functions ------------------------------------------------------------------------------------------------------------
fs_init() {
    if $DELETE_FOLDERS; then
          delete_folders
    else
        echo "Delete operation skipped. To delete default directories, Set DELETE_FOLDERS to true."
    fi

    create_folders
}

create_folders() {
    for folder in "${folders_to_create[@]}"; do
        mkdir -p ~/"$main_folder"/"$folder"
        ln -s ~/"$main_folder"/"$folder" ~/"$folder"
    done
    echo "Folders created and symlinks added successfully."
}

delete_folders() {
    for folder in "${folders_to_delete[@]}"; do
        rm -rf ~/"$folder"
    done
    echo "Folders deleted successfully."
}
# ----------------------------------------------------------------------------------------------------------------------

fs_init  # Execute script