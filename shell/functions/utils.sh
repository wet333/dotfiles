log() {
    local datetime
    datetime=$(date "+%Y-%m-%d %H:%M:%S.%3N")
    printf "\e[1;34m[%s] ==> %s\e[0m\n" "$datetime" "$*"
}