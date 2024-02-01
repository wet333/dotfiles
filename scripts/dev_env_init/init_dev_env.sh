#!/bin/bash

# List of packages needed for development
packages=(
    curl
    build-essential  # includes commonly used build tools like gcc, g++, make (C programming)
    git
    wget
    nano
    zip
    unzip
    sed
)

# Disable CD-ROM as a software source (error: tries to install from CD-ROM)
sudo sed -i '/^deb cdrom:/s/^/#/' /etc/apt/sources.list

# Update package lists
sudo apt update

# Packages instalation loop
for package in "${packages[@]}"
do
    # Check if the package is already installed
    if dpkg -l | grep -q $package
    then
        echo "$package is already installed."
    else
        # Install the package
        sudo apt install $package -y

        # Check if installation was successful
        if [ $? -eq 0 ]; then
            echo "$package has been successfully installed."
        else
            echo "Failed to install $package. Please check your internet connection and try again."
            exit 1
        fi
    fi
done

echo "All basic development tools have been installed."
