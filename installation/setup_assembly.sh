#!/bin/bash

echo "Installing assembly development required software..."
sudo apt install nasm
sudo apt install binutils
sudo apt install gdb
sudo apt install qemu
sudo apt install build-essential
echo "Assembly is ready!"