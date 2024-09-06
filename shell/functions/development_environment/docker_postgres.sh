# Postgres container management -(part of)-> Docker utilities - Prefix (docker_...)

# PostgreSQL Docker Management Functions
# ======================================
#
# The following functions provides a simple way to manage PostgreSQL databases
# using Docker containers. These functions will allow easy setup, configuration,
# and management of PostgreSQL instances.
# The main purpose of these functions is to simplify the process of setting up
# a PostgreSQL database for development.
#
# Functions:
# ----------
#
# 1. docker_pg_config_init
#    Initializes environment variables to default values.
#
# 2. docker_pg_config_get
#    Displays the current environment variables used for managing PostgreSQL.
#
# 3. docker_pg_config_set <field> <value>
#    Sets a specific configuration field to a new value.
#    Usage: docker_pg_config_set <field> <value>
#    Valid fields: username, password, container, volume, port
#
# 4. docker_pg_start
#    Starts a PostgreSQL container, Postgres data is persisted in a Docker volume
#    named "pg_data" or the value of the PG_VOLUME environment variable.
#
# 5. docker_pg_down
#    Stops and removes the PostgreSQL container.
#
# Configuration Variables:
# ------------------------
#
# - PG_USERNAME: PostgreSQL username (default: "username")
# - PG_PASSWORD: PostgreSQL password (default: "password")
# - PG_CONTAINER: Docker container name (default: "postgres_db")
# - PG_VOLUME: Docker volume name (default: "pg_data")
# - PG_PORT: PostgreSQL port (default: "5432")
#
# Some functions depends on the environment_utils.sh file to work properly.
# It should be located in:
# - $USER/dotfiles/shell/functions/terminal/environment_utils.sh

docker_pg_config_init() {
    env_set_var PG_USERNAME "username"
    env_set_var PG_PASSWORD "password"
    env_set_var PG_CONTAINER "postgres_db"
    env_set_var PG_VOLUME "pg_data"
    env_set_var PG_PORT "5432"
}

docker_pg_config_get() {
    echo "Current PostgreSQL Docker configuration:"
    env_user_ls | grep PG_
}

docker_pg_config_set() {
    local field=$1
    local value=$2

    if [ -z "$field" ] || [ -z "$value" ]; then
        echo "Usage: docker_pg_config_set <field> <value>"
        echo "Valid fields are: username, password, container, volume, port"
        echo "Example: docker_pg_config_set username myuser"
        return 1
    fi

    case $field in
        username)
            env_set_var PG_USERNAME "$value"
            ;;
        password)
            env_set_var PG_PASSWORD "$value"
            ;;
        container)
            env_set_var PG_CONTAINER "$value"
            ;;
        volume)
            env_set_var PG_VOLUME "$value"
            ;;
        port)
            env_set_var PG_PORT "$value"
            ;;
        *)
            echo "Invalid field. Valid fields are: username, password, container, volume, port"
            return 1
            ;;
    esac

    echo "Set $field to: $value"
}

docker_pg_start() {
    local container_name="$PG_CONTAINER"
    local volume_name="$PG_VOLUME"
    local username="$PG_USERNAME"
    local password="$PG_PASSWORD"
    local port="$PG_PORT"

    # Check if Docker is running
    if ! docker info >/dev/null 2>&1; then
        echo "Error: Docker is not running. Please start Docker and try again."
        return 1
    fi

    # Create a Docker volume if it doesn't exist
    if ! docker volume inspect "$volume_name" >/dev/null 2>&1; then
        echo "Creating Docker volume: $volume_name"
        docker volume create "$volume_name"
    fi

    # Check if the container is running
    if docker ps --format '{{.Names}}' | grep -q "^${container_name}$"; then
        echo "PostgreSQL container is already running."
    else
        echo "Starting PostgreSQL container..."
    fi

    docker run --name "$container_name" \
                -e POSTGRES_USER="$username" \
                -e POSTGRES_PASSWORD="$password" \
                -p "$port":5432 \
                -v "$volume_name":/var/lib/postgresql/data \
                -d postgres &>/dev/null

    echo "Connect using:"
    echo "  Host: localhost"
    echo "  Port: $port"
    echo "  Username: $username"
    echo "  Password: $password"
    echo "Data is persisted in Docker volume: $volume_name"
}

docker_pg_down() {
    local container_name="$PG_CONTAINER"

    # Check if Docker is running
    if ! docker info >/dev/null 2>&1; then
        echo "Error: Docker is not running. Please start Docker and try again."
        return 1
    fi

    # Check if the container is running
    if docker ps --format '{{.Names}}' | grep -q "^${container_name}$"; then
        echo "Stopping PostgreSQL container..."
        docker stop "$container_name"
        echo "PostgreSQL container stopped."
    else
        echo "PostgreSQL container is not running."
    fi

    # Check if the container exists (it might be stopped)
    if docker ps -a --format '{{.Names}}' | grep -q "^${container_name}$"; then
        echo "Removing PostgreSQL container..."
        docker rm "$container_name"
        echo "PostgreSQL container removed."
    else
        echo "PostgreSQL container does not exist."
    fi
}