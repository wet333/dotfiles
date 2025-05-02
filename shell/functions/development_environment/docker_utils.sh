# Docker utilities - Prefix (docker_...)

# Gets the Gateway ip for connection between host and containers
docker_get_ip() {
    docker network inspect bridge | grep Gateway | sed 's/^[ \t]*//;s/[ \t]*$//'
}

# Removes all dangling images from Docker
docker_rmi_dangling() {
    if [[ $(docker images -f "dangling=true" -q) ]]; then
        docker rmi "$(docker images -f "dangling=true" -q)"
    else
        echo "No dangling images to remove"
    fi
}