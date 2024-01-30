 
#!/bin/bash

# Update package index
sudo apt update

# Uninstall unofficial docker engines
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Get Official Docker installation script
curl -fsSL https://get.docker.com -o get-docker.sh

# Execute the script
sudo sh get-docker.sh

# Remove the script
rm ./set-docker.sh

# Start docker on startup
sudo systemctl enable docker
