#!/bin/bash

# Script to configure Docker to run without sudo

# Check if script is run as root
if [[ $EUID -eq 0 ]]; then
    echo "This script should NOT be run as root or with sudo."
    echo "Please run it as your regular user."
    exit 1
fi

echo "Setting up Docker to run without sudo..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed or not in PATH. Please install Docker first."
    exit 1
fi

# Create the docker group if it doesn't exist
if ! getent group docker > /dev/null; then
    echo "Creating docker group..."
    sudo groupadd docker
fi

# Add current user to the docker group
echo "Adding user $USER to the docker group..."
sudo usermod -aG docker $USER

# Check if Docker socket exists and set permissions
if [ -S /var/run/docker.sock ]; then
    echo "Setting permissions on Docker socket..."
    sudo chmod 666 /var/run/docker.sock
fi

# Restart Docker service
echo "Restarting Docker service..."
sudo systemctl restart docker

echo "Setup complete!, Reloading shell session."
reload_shell