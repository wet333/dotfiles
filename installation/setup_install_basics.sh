#!/bin/bash

echo "Installing basic developer software"

# wget: CLI tool for downloading files (HTTP, HTTPS, FTP protocols).
# htop: Interactive process viewer for system resources.
# curl: CLI tool for transferring data using various protocols.
# tree: Displays directory structure as a tree.
# tmux: Terminal multiplexer for managing multiple sessions.
# unzip: Extracts files from ZIP archives.
# ncdu: Ncurses-based disk usage analyzer.
# iftop: Monitors real-time network bandwidth.
# build-essential: Essential compiler tools (gcc, g++, make, etc.).
# git: Distributed version control system.
# gdb: GNU Debugger for analyzing code.
# cmake: Cross-platform build system generator for C/C++.
# valgrind: Tool for memory debugging and profiling.

sudo apt install -y \
    wget htop curl tree tmux unzip ncdu iftop \
    build-essential git gdb cmake valgrind \
    linux-headers-$(uname -r)

echo "Basic dev-tools installed."
