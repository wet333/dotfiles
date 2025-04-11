# .dotfiles

This repository contains my personal configuration/functionality for Linux environments.

## Directory Structure

* `bin/`: Contains executable scripts or binaries intended to be added to your system's `PATH` for global access.
* `shell/`: Bash terminal configuration files (aliases, environment variables and prompt settings).
* `shell/functions/`: A collection of reusable Bash functions sourced by the shell configuration to streamline and personalize common command-line tasks.
* `scripts/`: Standalone utility scripts used for various automation, setup, or maintenance tasks (typically run manually or less frequently than items in `bin/`).
* `installation/`: Scripts specifically designed to run **_only_** during the initial setup/installation process of these dotfiles.
* `services/`: **(...Work in Progress)** Systemd services for managing background processes.
* `install.sh`: The main installation script responsible for setting up the dotfiles in your home directory.

## Installation

This installation script is primarily intended for a fresh Linux system, but can also be run to update an existing installation of these dotfiles.

**⚠️ Warning:** The installation script (`install.sh`) will likely modify files in your home directory (e.g., `~/.bashrc`, `~/.profile`). It might create symbolic links or copy files, potentially overwriting existing configurations. Furthermore, the script may delete specific files or directories if they conflict with the new setup.

**👉 It is strongly recommended to:**

1. **Review** the `install.sh` script to understand what it does.
2. Run one of this commands:

```bash
    sudo apt update && \
    sudo apt install -y wget git && \
    wget -qO- https://raw.githubusercontent.com/wet333/dotfiles/master/install.sh | bash
```

```bash
    sudo apt update && \
    sudo apt install -y curl git && \
    curl -sL https://raw.githubusercontent.com/wet333/dotfiles/master/install.sh | bash
```
