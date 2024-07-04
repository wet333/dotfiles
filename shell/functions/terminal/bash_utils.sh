# Reload
reload_shell() {
  source "$HOME"/.bashrc || echo "Failed to source .bashrc"
}

# Bash Utils - Prefix (bash_...)

bash_available_shells() {
  cat /etc/shells
  echo "Current shell: $SHELL"
}

bash_print_user_defined_functions() {
    # nvm and __nvm are functions outside the user defined ones
    # __ is the prefix for ignored user-defined functions
    local ignored_prefixes=("nvm" "__nvm" "__")
    local function_list=$(declare -F | awk '{print $3}')

    # If user includes an argument, searches only functions that starts with that prefix
    local user_defined_prefix_filter=$1

    # Defines if a function should be ignored based on the ignored_prefixes list
    function __is_ignored() {
        local func_name=$1
        for prefix in "${ignored_prefixes[@]}"; do
            if [[ $func_name == $prefix* ]]; then
                return 0
            fi
        done
        return 1
    }

    if [ -n "$user_defined_prefix_filter" ]; then
        echo "$function_list" | grep "$user_defined_prefix_filter"
    else
        for func in $function_list; do
            if __is_ignored "$func"; then
                continue
            fi
            echo "$func"
        done
    fi
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
