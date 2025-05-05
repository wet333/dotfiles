# Reload
reload_shell() {
  source "$HOME"/.bashrc || echo "Failed to source .bashrc"
}

# Bash Utils - Prefix (bash_...)

terminal_available_shells() {
  cat /etc/shells
  echo "Current shell: $SHELL"
}

terminal_print_user_defined_functions() {
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

# Function to display all available terminal characters
show_characters() {
    echo "Displaying available terminal characters:"
    echo "=========================================="
    
    # ASCII characters (standard printable)
    echo "ASCII characters (32-126):"
    for i in $(seq 32 126); do
        printf "\\$(printf '%03o' $i) "
        # Add a newline every 10 characters for readability
        if (( (i-31) % 10 == 0 )); then echo ""; fi
    done
    echo -e "\n"
    
    # Extended ASCII characters (if supported by terminal)
    echo "Extended ASCII characters (128-255):"
    for i in $(seq 128 255); do
        printf "\\$(printf '%03o' $i) "
        # Add a newline every 10 characters for readability
        if (( (i-127) % 10 == 0 )); then echo ""; fi
    done
    echo -e "\n"
    
    # Some common Unicode blocks if supported by terminal
    echo "Some Unicode blocks (examples):"
    echo "Box Drawing:"
    echo "┌─┬─┐ ╔═╦═╗ ╒═╤═╕ ╓─╥─╖"
    echo "│ │ │ ║ ║ ║ │ │ │ ║ ║ ║"
    echo "├─┼─┤ ╠═╬═╣ ╞═╪═╡ ╟─╫─╢"
    echo "└─┴─┘ ╚═╩═╝ ╘═╧═╛ ╙─╨─╜"
    
    echo "Block Elements:"
    echo "▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▉ ▊ ▋ ▌ ▍ ▎ ▏"
    echo "▏ ▎ ▍ ▌ ▋ ▊ ▉ █ ▇ ▆ ▅ ▄ ▃ ▂ ▁"
    
    echo "Arrows:"
    echo "← ↑ → ↓ ↔ ↕ ↖ ↗ ↘ ↙ ⇐ ⇑ ⇒ ⇓ ⇔ ⇕"
    
    echo "Misc Symbols:"
    echo "♠ ♣ ♥ ♦ ☺ ☻ ♂ ♀ ♪ ♫ ☼ ♩ ✓ ✔ ✗ ✘"
}

# Function to display text with different colors and styles
show_colors() {
    echo "Terminal Colors and Styles:"
    echo "==========================="
    
    # Text colors (Foreground)
    echo "Foreground Colors (Normal):"
    for i in $(seq 30 37); do
        echo -e "\e[${i}mColor $i\e[0m"
    done
    
    echo -e "\nForeground Colors (Bright):"
    for i in $(seq 90 97); do
        echo -e "\e[${i}mColor $i\e[0m"
    done
    
    # Background colors
    echo -e "\nBackground Colors (Normal):"
    for i in $(seq 40 47); do
        echo -e "\e[${i}mBackground $i\e[0m"
    done
    
    echo -e "\nBackground Colors (Bright):"
    for i in $(seq 100 107); do
        echo -e "\e[${i}mBackground $i\e[0m"
    done
    
    # Text styles
    echo -e "\nText Styles:"
    echo -e "\e[1mBold\e[0m"
    echo -e "\e[2mDim\e[0m"
    echo -e "\e[3mItalic\e[0m"
    echo -e "\e[4mUnderline\e[0m"
    echo -e "\e[5mBlink\e[0m"
    echo -e "\e[7mReverse\e[0m"
    echo -e "\e[9mStrikethrough\e[0m"
    
    # Combinations
    echo -e "\nSome Combinations:"
    echo -e "\e[1;31mBold Red\e[0m"
    echo -e "\e[3;32mItalic Green\e[0m"
    echo -e "\e[4;33mUnderlined Yellow\e[0m"
    echo -e "\e[1;34;47mBold Blue on White Background\e[0m"
    echo -e "\e[1;97;45mBright White Bold on Magenta Background\e[0m"
    
    # 256 color mode
    echo -e "\n256 Color Mode Examples:"
    for i in $(seq 0 15); do
        echo -ne "\e[38;5;${i}m Color $i \e[0m"
        if (( (i+1) % 8 == 0 )); then echo ""; fi
    done
    
    echo -e "\n\nFor 256 colors (if supported by your terminal):"
    echo "Use: echo -e '\e[38;5;<0-255>m Text \e[0m' for foreground"
    echo "Use: echo -e '\e[48;5;<0-255>m Text \e[0m' for background"
    
    # RGB colors (if supported)
    echo -e "\nRGB Colors (if supported by your terminal):"
    echo "Use: echo -e '\e[38;2;<r>;<g>;<b>m Text \e[0m' for foreground"
    echo "Use: echo -e '\e[48;2;<r>;<g>;<b>m Text \e[0m' for background"
    
    echo -e "\nExamples:"
    echo -e "\e[38;2;255;0;0mRGB Red\e[0m"
    echo -e "\e[38;2;0;255;0mRGB Green\e[0m"
    echo -e "\e[38;2;0;0;255mRGB Blue\e[0m"
    echo -e "\e[38;2;255;165;0mRGB Orange\e[0m"
    echo -e "\e[48;2;128;0;128m RGB Purple Background \e[0m"
}