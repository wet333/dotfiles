# dotfiles

- /bash: This directory includes all modifications related to the Bash shell, such as custom prompts, aliases, and environment variables.

- /functions: In this directory, you'll find various Bash functions that I use to streamline common tasks and operations in my shell environment. These functions are designed to simplify repetitive tasks and improve productivity.

- /scripts: The scripts directory contains a collection of Bash scripts that serve various purposes. These scripts can include installation scripts for software packages, system utilities, and other helpful tools.

- **install.sh**: This script is a simple installer that creates a symbolic link to the .bashrc file in your home directory. By doing so, it ensures that your Bash configuration is applied every time you start a new shell session.

## Installation

Clone this repository to your local machine:
```bash
    git clone https://github.com/yourusername/dotfiles.git
```
Navigate to the repository directory:
```bash
    cd dotfiles
```
Run the installation script to create a symbolic link to the .bashrc file:
```bash
    ./install.sh
```