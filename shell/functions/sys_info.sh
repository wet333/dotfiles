# System Info - Prefix (sysinf_...)

sysinf_list_installed_programs() {
    # Directory containing the dpkg history
    local log_dir="/var/log/apt"

    process_log_file() {
        local log_file=$1
        # zgrep is grep for gzipped files
        zgrep " install " "$log_file" | awk '{print $1, $2, $4}'
    }

    echo "List of programs installed, ordered by date:"
    for log_file in "$log_dir"/history.log.*.gz; do
        if [ -f "$log_file" ]; then
            process_log_file "$log_file"
        fi
    done | sort
}