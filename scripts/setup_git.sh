#!/bin/bash

# Check if email and username are provided
if [ $# -ne 2 ]; then
    echo "Error: Missing arguments."
    echo "Usage: "
    echo "  $0 <your-email> <your-username>"
    echo
    echo "Steps to generate a Personal Access Token (PAT):"
    echo "1. Go to GitHub and log in to your account."
    echo "2. Navigate to Settings > Developer settings > Personal access tokens."
    echo "3. Click on 'Generate new token'."
    echo "4. Give your token a descriptive name, select the required scopes (e.g., repo, workflow), and click 'Generate token'."
    echo "5. Copy the generated token. You will use it when prompted by this script."
    echo
    exit 1
fi

EMAIL=$1
USERNAME=$2

# Prompt for the Personal Access Token
read -sp "Enter your Personal Access Token: " TOKEN
echo

# Configure Git with the provided email and username
git config --global user.email "$EMAIL"
git config --global user.name "$USERNAME"

# Configure Git to use the personal access token
git config --global credential.helper store

# Create a file to store the credentials
echo "https://$USERNAME:$TOKEN@github.com" > ~/.git-credentials

# Verify the configuration
git config --global --list | grep "user.email"
git config --global --list | grep "user.name"
cat ~/.git-credentials

echo "GitHub authentication has been set up with the provided email, username, and personal access token."
