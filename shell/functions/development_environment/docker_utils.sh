# Docker utilities - Prefix (docker_...)

# Gets the Gateway ip for connection between host and containers
docker_get_ip() {
    docker network inspect bridge | grep Gateway | sed 's/^[ \t]*//;s/[ \t]*$//'
}

docker_config_no_sudo() {
    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo systemctl restart docker
}