#!/bin/bash

echo "Installing assembly development required software..."
sudo apt install -y build-essential
sudo apt install -y gdb
sudo apt install -y nasm
sudo apt install -y binutils
sudo apt install -y qemu-system qemu-user-static
echo "Assembly is ready!"