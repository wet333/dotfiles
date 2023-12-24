yt_off() {
    if ! grep -q "0.0.0.0 youtube.com" /etc/hosts; then
        echo "0.0.0.0 youtube.com" | sudo tee -a /etc/hosts > /dev/null
        echo "0.0.0.0 www.youtube.com" | sudo tee -a /etc/hosts > /dev/null
        echo "YouTube is now blocked."
    fi
}

yt_on() {
    
    # Configs and Variables
    local enable_time="$1"
    local reason="$2"
    local LOGS_DIR="$HOME/dotfiles/logs"
    local LOG_FILE="$LOGS_DIR/youtube_access.log"
    
    # Validate input
    if [[ -z "$enable_time" || -z "$reason" ]]; then
        echo "Usage --> yt_on <duration_in_minutes> <reason>"
        return 1
    fi

    # Create the log directory if it doesn't exist
    mkdir -p "$LOGS_DIR"

    # Calculate the end time
    local end_time=$(date -d "+$enable_time minutes" +%s)
    
    # Unblock YouTube temporarily
    echo "Temporarily enabling YouTube for $enable_time minutes due to: $reason"
    sudo sed -i '/youtube.com/d' /etc/hosts
    
    # Wait for the specified duration
    sleep "$enable_time"s
    
    yt_off # Block YouTube again
    
    # Log the reason and duration
    echo "$(date '+%d/%m/%y %H:%M') /#/ YouTube access enabled for $enable_time seconds /#/ Reason? -> $reason" >> "$LOG_FILE"
}

yt_enable() {
    sudo sed -i '/youtube.com/d' /etc/hosts
}