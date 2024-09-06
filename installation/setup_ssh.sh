#!/bin/bash

# Install OpenSSH server and client
echo "Installing OpenSSH"
sudo apt install -y openssh-client
sudo apt install -y openssh-server

# Start and enable SSH service
sudo systemctl start ssh
sudo systemctl enable ssh

# Check if SSH key already exists
if [ -f ~/.ssh/id_rsa ]; then
    echo "SSH key already exists. Skipping key generation."
else
    # Generate SSH key pair
    echo "Generating new SSH key..."
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
    echo "SSH key generated."
fi

# Display the public key
echo "Here's your public SSH key:"
cat ~/.ssh/id_rsa.pub

echo "SSH Server installed and ready for connections!"