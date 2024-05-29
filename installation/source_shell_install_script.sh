source_all_sh_files() {
    local dir="$1"
    for file in "$dir"/*.sh; do
        if [ -f "$file" ]; then
            . "$file"
        fi
    done
    for subdir in "$dir"/*; do
        if [ -d "$subdir" ]; then
            source_all_sh_files "$subdir"
        fi
    done
}