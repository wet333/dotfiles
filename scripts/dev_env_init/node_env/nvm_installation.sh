#!/bin/bash

# NVM github docs: https://github.com/nvm-sh/nvm

# Check if curl is installed, if not, install it
if ! command -v curl &> /dev/null; then
    sudo apt update
    sudo apt install -y curl
fi

# Download and execute install script
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
