# Postgres queries - Prefix (pg_...)

pg_new_db() {
    if [ $# -ne 1 ]; then
        echo "Usage: docker_pg_new_db <db_name>"
        return 1
    fi

    local container_name="$PG_CONTAINER"
    db_name="$1"
    username="$PG_USERNAME"

    # Check if the container is running
    if ! docker ps | grep -q "$container_name"; then
        echo "Error: postgres_db container is not running"
        return 1
    fi

    # Create the database
    if docker exec postgres_db psql -U "$username" -c "CREATE DATABASE $db_name;"; then
        echo "Database '$db_name' created successfully"
    else
        echo "Error: Failed to create database '$db_name'"
        return 1
    fi
}

pg_delete_db() {
    if [ $# -ne 1 ]; then
        echo "Usage: docker_pg_delete_db <db_name>"
        return 1
    fi

    local container_name="$PG_CONTAINER"
    db_name="$1"
    username="$PG_USERNAME"

    # Check if the container is running
    if ! docker ps | grep -q postgres_db; then
        echo "Error: postgres_db container is not running"
        return 1
    fi

    # Check if the database exists
    if ! docker exec postgres_db psql -U "$username" -lqt | cut -d \| -f 1 | grep -qw "$db_name"; then
        echo "Error: Database '$db_name' does not exist"
        return 1
    fi

    # Delete the database
    if docker exec postgres_db psql -U "$username" -c "DROP DATABASE $db_name;"; then
        echo "Database '$db_name' deleted successfully"
    else
        echo "Error: Failed to delete database '$db_name'"
        return 1
    fi
}