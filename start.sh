#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print with color
print() {
    echo -e "${BLUE}==>${NC} $1"
}

print_error() {
    echo -e "${RED}Error:${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}Warning:${NC} $1"
}

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    print "Creating .env file from .env.example..."
    cp .env.example .env
fi

# Stop any running Ollama instance
if lsof -Pi :11434 -sTCP:LISTEN -t >/dev/null ; then
    print "Stopping local Ollama instance..."
    pkill ollama
fi

# Start the services
print "Starting Ollama services..."
docker-compose up -d

# Function to wait for Ollama to be ready
wait_for_ollama() {
    local max_attempts=30
    local attempt=1
    
    print "Waiting for Ollama service to be ready..."
    while [ $attempt -le $max_attempts ]; do
        if curl -s http://localhost:11434/api/health >/dev/null; then
            return 0
        fi
        sleep 2
        attempt=$((attempt + 1))
    done
    return 1
}

# Create ollama alias
SHELL_FILE=""
if [ -f "$HOME/.zshrc" ]; then
    SHELL_FILE="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_FILE="$HOME/.bashrc"
fi

if [ ! -z "$SHELL_FILE" ]; then
    # Check if alias already exists
    if ! grep -q 'alias ollama="docker exec -it ollama ollama"' "$SHELL_FILE"; then
        print "Adding ollama alias to $SHELL_FILE..."
        echo 'alias ollama="docker exec -it ollama ollama"' >> "$SHELL_FILE"
        print "To use the ollama command, please run: ${GREEN}source $SHELL_FILE${NC}"
    fi
fi

# Wait for services to be ready
if ! wait_for_ollama; then
    print_error "Ollama service failed to start within the timeout period"
    print_warning "Please check Docker logs with: docker logs ollama"
    exit 1
fi

# Function to download model with retry logic
download_model() {
    local model=$1
    local max_attempts=3
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        print "Attempting to download $model (attempt $attempt of $max_attempts)..."
        if docker exec ollama ollama pull $model; then
            print "${GREEN}Successfully downloaded $model!${NC}"
            return 0
        else
            print_warning "Download attempt $attempt failed"
            if [ $attempt -lt $max_attempts ]; then
                print "Waiting 10 seconds before retrying..."
                sleep 10
            fi
        fi
        attempt=$((attempt + 1))
    done
    
    print_error "Failed to download $model after $max_attempts attempts"
    return 1
}

# Offer to download a starter model
print "Would you like to download a starter model? We recommend mistral (smaller) or llama2."
echo -e "1) mistral (recommended for first-time setup)"
echo -e "2) llama2"
echo -e "3) skip for now"
read -p "Enter your choice (1-3): " choice

case $choice in
    1)
        download_model "mistral"
        ;;
    2)
        download_model "llama2"
        ;;
    3)
        print "Skipping model download"
        ;;
    *)
        print_warning "Invalid choice. Skipping model download"
        ;;
esac

# Print success message
print "🚀 Setup complete! You can now:"
echo -e "${GREEN}1.${NC} Access the WebUI at ${GREEN}http://localhost:8080${NC}"
echo -e "${GREEN}2.${NC} Use the ollama command in your terminal (after sourcing your shell config)"
echo -e "${GREEN}3.${NC} Example commands:"
echo -e "   ${BLUE}ollama list${NC}         # List available models"
echo -e "   ${BLUE}ollama pull mistral${NC} # Download mistral model"
echo -e "   ${BLUE}ollama run mistral${NC}  # Chat with mistral"

print "If you encounter any issues:"
echo -e "1. Check Docker logs:    ${BLUE}docker logs ollama${NC}"
echo -e "2. Check WebUI logs:     ${BLUE}docker logs ollama-webui${NC}"
echo -e "3. Restart services:     ${BLUE}docker-compose restart${NC}"
