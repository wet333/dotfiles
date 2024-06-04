reload_shell() {
  source "$HOME"/.bashrc || echo "Failed to source .bashrc"
}

# Bash Utils - Prefix (bash_...)

bash_available_shells() {
  cat /etc/shells
  echo "Current shell: $SHELL"
}

bash_show_terminal_colors() {
    for ((bg = 40; bg <= 47; bg++)); do
        for ((fg = 30; fg <= 37; fg++)); do
            echo -en "\e[${bg};${fg}m  ${bg}-${fg}  \e[0m"
        done
        echo
    done
}

bash_show_ascii_characters() {
    for ((i = 32; i <= 126; i++)); do
        printf "Decimal: %3d | Hexadecimal: 0x%02X | Character: %s\n" "$i" "$i" "$(printf "\\$(printf %o "$i")")"
    done
}

bash_show_ascii_art_characters() {
    for ((i = 32; i <= 255; i++)); do
        printf "Decimal: %3d | Hexadecimal: 0x%02X | Character: %s\n" "$i" "$i" "$(printf "\\$(printf %o "$i")")"
    done
}
