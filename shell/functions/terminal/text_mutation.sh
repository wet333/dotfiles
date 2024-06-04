# Text-mutation utility functions - Prefix (textm_...)

textm_to_upper() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

textm_to_lower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}


# A function that capitalizes the first letter of a string
textm_capitalize() {
    # if string is empty, return instructions
    if [[ -z "$1" ]]; then
        echo "Usage: textm_capitalize <string>"
        return 1
    fi

    textm_char_to_upper_by_index "$1" "$(_get_first_alphanumeric_index "$1")"
}

textm_char_to_upper_by_index(){
    # if string or index is empty, return instructions
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Usage: textm_char_to_upper_by_index <string> <index>"
        return 1
    fi

    local input="$1"
    local index="$2"

    local part1="${input:0:index}"
    local char="${input:index:1}"
    char=$(echo "$char" | tr '[:lower:]' '[:upper:]')
    local part3="${input:index+1}"

    echo "$part1$char$part3"
}

# A function that returns the index number of the first alphanumeric character in a string (including spaces)
_get_first_alphanumeric_index() {
     local input="$1"
     local length=${#input}

     for (( i=0; i<length; i++ )); do
         char="${input:i:1}"
         if [[ "$char" =~ [a-zA-Z] ]]; then
             echo "$i"
             return 0
         fi
     done

     echo "Error: No alphanumeric character found in string"
     return 1
}