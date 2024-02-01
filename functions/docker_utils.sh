start_pg_db() {
    
    # Get current user home path
    home_path=$(readlink -f ~)

    # Test Database Configuration
    local db_name="test_database"
    local db_user="test_user"
    local db_password="password"
    local host_path="$home_path/pg_test_data"

    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Please install Docker to use this function."
        return 1
    fi

    # Run PostgreSQL container
    docker run -d \
        --name "$db_name" \
        -e POSTGRES_DB="$db_name" \
        -e POSTGRES_USER="$db_user" \
        -e POSTGRES_PASSWORD="$db_password" \
        -v "$host_path":/var/lib/postgresql/data \
        -p 5432:5432 \
        postgres:latest

    echo "PostgreSQL database '$db_name' is now running."
}

start_pgadmin() {

    # Config variables
    local email="test_user@example.com"
    local password="password"
    local container_name="pgadmin"
    local host_port=5433

    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Please install Docker to use this function."
        return 1
    fi

    # Run PgAdmin container
    docker run -d \
        --name $container_name \
        -e "PGADMIN_DEFAULT_EMAIL=$email" \
        -e "PGADMIN_DEFAULT_PASSWORD=$password" \
        -p $host_port:80 \
        dpage/pgadmin4:latest

    echo "PgAdmin is now running at localhost:$host_port."
}

# Gets the Gateway ip for connection between host and containers
function docker_get_ip() {
    docker network inspect bridge | grep Gateway
}