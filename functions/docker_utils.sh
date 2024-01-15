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