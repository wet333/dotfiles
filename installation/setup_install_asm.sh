#!/bin/bash

echo "Starting installation and setup for Assembly development..."

# binutils: includes the GNU assembler, linker, and objdump.
# NASM: is a widely used assembler for x86 architecture and 
# YASM: is a fork that supports multiple syntaxes.
# gdb: GNU Debugger for debugging and analyzing binaries
# Radare2: a powerful open-source framework for reverse engineering.
sudo apt-get install -y binutils nasm yasm gdb radare2

echo "Assembly is ready to go!"