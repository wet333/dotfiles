#!/usr/bin/env bash

# Get sudo permissions for this script
sudo echo "Getting sudo permissions..."

# Bash config, create a symlink to the .bashrc file
sudo ln -sf ~/dotfiles/.bashrc ~/.bashrc

# Create symlinks for each .service file in the services directory
for file in ~/dotfiles/services/*.service; do

    absolute_path=$(realpath ~/dotfiles/scripts/test-service.sh)

    # Edit the .service file to replace the ExecStart path with the absolute path of current service script
    sed -i "s;ExecStart=.*;ExecStart=/usr/bin/bash $absolute_path;" "$file"

    # Get the filename without the path
    filename=$(basename "$file")

    # if the symlink already exists, delete it and create a new one and restart the service, else just create the symlink and start the service
    if [ -f "/etc/systemd/system/$filename" ]; then
        sudo rm "/etc/systemd/system/$filename"
        sudo ln -s "$file" "/etc/systemd/system/$filename"
        sudo systemctl daemon-reload
        sudo systemctl restart "$filename"
    else
        sudo ln -s "$file" "/etc/systemd/system/$filename"
        sudo systemctl daemon-reload
        sudo systemctl start "$filename"
    fi

done