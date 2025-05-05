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

# Restarts docker service
docker_restart() {
    echo "Stopping Docker service..."
    if command -v systemctl &> /dev/null; then
        sudo systemctl stop docker
        echo "Waiting for Docker to completely stop..."
        sleep 3
        echo "Starting Docker service..."
        sudo systemctl start docker
    elif command -v service &> /dev/null; then
        sudo service docker stop
        echo "Waiting for Docker to completely stop..."
        sleep 3
        echo "Starting Docker service..."
        sudo service docker start
    else
        echo "Error: Could not find systemctl or service commands. Please restart Docker manually."
        return 1
    fi
    
    echo "Checking Docker service status..."
    if docker info &> /dev/null; then
        echo "Docker restarted successfully!"
        return 0
    else
        echo "Docker restart failed. Please check logs with 'sudo journalctl -u docker.service' or restart manually."
        return 1
    fi
}