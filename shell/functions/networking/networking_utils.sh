# Networking utility functions - Prefix (net_...)

# Determines if an IP is private or public
# Usage: net_ip_type <ip_address>
net_ip_type() {
    IP=$1
    # Check if argument is provided
    if [ -z "$IP" ]; then
        echo "Error: No IP provided"
        echo "Usage: net_ip_type <ip_address>"
        echo "Example: net_ip_type 192.168.1.1"
        return 1
    fi
    
    # Check if IP is private
    if [[ $IP =~ ^10\. ]] || [[ $IP =~ ^172\.(1[6-9]|2[0-9]|3[0-1])\. ]] || [[ $IP =~ ^192\.168\. ]]; then
        echo "private (local)"
    else
        echo "public (internet)"
    fi
}

net_fix_dns() {
    echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
}