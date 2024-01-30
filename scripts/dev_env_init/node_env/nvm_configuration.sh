#!/bin/bash

# Check if nvm is installed
if command -v nvm &> /dev/null; then

    source ~/.bashrc

    # NVM Configurations START

    nvm install --lts # Install the LTS version of Node.js

    # NVM Configurations END
else
    echo "NVM is not installed. Please install NVM first."
    exit 1
fi
