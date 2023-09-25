show_terminal_colors() {
    for ((bg = 40; bg <= 47; bg++)); do
        for ((fg = 30; fg <= 37; fg++)); do
            echo -en "\e[${bg};${fg}m  ${bg}-${fg}  \e[0m"
        done
        echo
    done
}

show_ascii_characters() {
    for ((i = 32; i <= 126; i++)); do
        printf "Decimal: %3d | Hexadecimal: 0x%02X | Character: %s\n" "$i" "$i" "$(printf "\\$(printf %o "$i")")"
    done
}

show_ascii_art_characters() {
    for ((i = 32; i <= 255; i++)); do
        printf "Decimal: %3d | Hexadecimal: 0x%02X | Character: %s\n" "$i" "$i" "$(printf "\\$(printf %o "$i")")"
    done
}
