#!/bin/bash

# Function to run Ollama commands inside the container
function run_ollama_command() {
    docker exec -it ollama ollama "$@"
}

# Check if command is provided
if [ $# -eq 0 ]; then
    echo "Usage: ./ollama-cli.sh [command] [arguments]"
    echo "Examples:"
    echo "  ./ollama-cli.sh list"
    echo "  ./ollama-cli.sh run llama2"
    echo "  ./ollama-cli.sh pull llama2"
    exit 1
fi

# Run the command
run_ollama_command "$@"
