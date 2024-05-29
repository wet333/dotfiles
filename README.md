# dotfiles

This repository contains my personal configuration/functionality for Linux environments.

### Directory Structure:

* **/shell:** Shell customization files, such as custom prompts, aliases, and environment variables.

* **/shell/functions:** Bash functions that I use to streamline common tasks and operations in my shell environment.

* **/scripts:** A collection of Bash scripts that serve various purposes. These scripts can include installation scripts for software packages, system utilities, and other helpful tools.

* **/system:** Scripts that sets-up the environment, and the way that linux works for me.

* **/system/files:** Scripts for handling and configuring the way I store my data.

* **install.sh**: Simple installer that appends a bash snippet to ~/.bashrc, By doing so, your shell configuration files are applied to every new session.

## Installation via script

To download all configurations run one of the following commands:
```bash
    wget -qO- https://raw.githubusercontent.com/wet333/dotfiles/master/install.sh | bash
```
```bash
    curl -s https://raw.githubusercontent.com/wet333/dotfiles/master/install.sh | bash
```

By default, the installation script will only activate **shell** related configurations (prompt, aliases, functions, environment variables).

If you want to install other configurations, you can do it running the **\*_init.sh** scripts inside
the system's folders. Further configurations will and should follow this structure.