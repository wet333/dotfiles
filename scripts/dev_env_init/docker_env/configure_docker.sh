#!/bin/bash

# Check if the docker group exists
if grep -E '^docker' /etc/group > /dev/null; then
    echo "Docker group already exists."
else
    echo "Creating docker group..."
    sudo groupadd docker
fi

# Add the current user to the docker group
echo "Adding current user to the docker group..."
sudo usermod -aG docker $USER

echo "Restarting Docker service..."
sudo systemctl restart docker

echo "Verifying group membership..."
groups $USER

echo "Sudo will not be needed to run docker commands anymore."

echo "Please restart for the changes to take effect."
