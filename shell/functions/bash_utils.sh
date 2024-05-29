my_cd() {
    builtin cd "$@"

    # Add extra commands here ...
    set_prompt # dinamically sets the command prompt after cd
}

function run_script_as_deamon() {

    local bin_dir=$HOME/dotfiles/bin
    
    local script_file=$bin_dir/$1
    local script_name="${1%.sh}" # Extract the .sh from filename

    local logs_dir=$HOME/dotfiles/temp
    local logs_file="$logs_dir/${script_name}_logs.log"

    if [ ! -e $logs_dir ]; then
        mkdir $logs_dir
    fi

    if [ ! -e $logs_file ]; then 
        touch $logs_file
    fi

    if [ ! -x $script ]; then
        echo "Script is not executable: $script_file"
        return 1
    else
        nohup $script_file >>$logs_file 2>&1 <&- &
        echo 'Running ' $script_file ' as deamon...'
        return 0
    fi
}

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
