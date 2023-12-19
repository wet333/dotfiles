# dotfiles

This repository contains my personal dotfiles for the Bash shell. It includes my custom Bash configuration, which is designed to improve productivity and streamline common tasks. It also includes a collection of Bash functions and scripts that I use to automate various tasks and operations.

### Here is a brief overview of the contents of this repository:

- /bash: This directory includes all modifications related to the Bash shell, such as custom prompts, aliases, and environment variables.

- /functions: In this directory, you'll find various Bash functions that I use to streamline common tasks and operations in my shell environment. These functions are designed to simplify repetitive tasks and improve productivity.

- /scripts: The scripts directory contains a collection of Bash scripts that serve various purposes. These scripts can include installation scripts for software packages, system utilities, and other helpful tools.

- /services: This directory contains systemd service files that I use to manage various services on my system.

- **install.sh**: This script is a simple installer that creates a symbolic link to the .bashrc file in your home directory. By doing so, it ensures that your Bash configuration is applied every time you start a new shell session.

## Installation

Clone this repository into your home directory:
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