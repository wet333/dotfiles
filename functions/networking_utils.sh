# Networking utility functions - Prefix (net_...)

net_ip_type() {
    IP=$1
    if [[ $IP =~ ^10\. ]] || [[ $IP =~ ^172\.(1[6-9]|2[0-9]|3[0-1])\. ]] || [[ $IP =~ ^192\.168\. ]]; then
        echo "private (local)"
    else
        echo "public (internet)"
    fi
}

net_fix_dns() {
    echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
}