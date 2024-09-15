#!/bin/bash

# Docker Services Management Script
#
# This script manages the deployment of four Docker containers:
# 1. ChromaDB (chroma_db):
#    - Port: 3005 (mapped to container port 8000)
#    - Purpose: Vector database for storing and retrieving embeddings
#    - Volume: chroma-data (persists data)
#    - Environment variables:
#      * ALLOW_RESET=true
#      * ANONYMIZED_TELEMETRY=false
#
# 4. Ollama (ollama):
#    - Port: 3008 (mapped to container port 11434)
#    - Purpose: Runs large language models locally
#    - Volume: ollama (persists model data)
#    - Uses GPU acceleration (--gpus all)
#
# Usage:
# 1. Ensure Docker is installed and running on your system.
# 2. Replace 'your_openai_api_key_here' with your actual OpenAI API key.
# 3. Run the script with: bash script_name.sh
#
# Note: This script uses host.docker.internal to allow containers to communicate.
# Ensure this is supported in your Docker environment, or replace with appropriate IP addresses.

# Set variables for container names and images
CHROMA_CONTAINER="chroma_db"
CHROMA_IMAGE="ghcr.io/chroma-core/chroma:latest"
OLLAMA_CONTAINER="ollama"
OLLAMA_IMAGE="ollama/ollama:latest"

# Function to start a container
start_container() {
    container_name=$1
    image_name=$2
    port_mapping=$3
    extra_params=$4
    if [ ! "$(docker ps -q -f name=^/${container_name}$)" ]; then
        if [ ! "$(docker ps -aq -f status=exited -f name=^/${container_name}$)" ]; then
            echo "Starting $container_name..."
            docker run -d --name $container_name $port_mapping $extra_params $image_name
        else
            echo "Starting existing $container_name container..."
            docker start $container_name
        fi
    else
        echo "$container_name is already running."
    fi
}

# Start ChromaDB
start_container $CHROMA_CONTAINER $CHROMA_IMAGE "-p 3009:8000" "-e ALLOW_RESET=true -e ANONYMIZED_TELEMETRY=false -v chroma-data:/chroma/chroma"

# Start Ollama
start_container $OLLAMA_CONTAINER $OLLAMA_IMAGE "-p 3008:11434" "--gpus all -v ollama:/root/.ollama"

echo "All containers have been started. Please check their status using 'docker ps'."