recursive_sourcing() {
    local dir="$1"
    for file in "$dir"/*.sh; do
        if [ -f "$file" ]; then
            . "$file"
        fi
    done
    for subdir in "$dir"/*; do
        if [ -d "$subdir" ]; then
            recursive_sourcing "$subdir"
        fi
    done
}