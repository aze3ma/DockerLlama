#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print with color
print() {
    echo -e "${BLUE}==>${NC} $1"
}

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Please install Docker Compose first."
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

# Create ollama alias
SHELL_FILE=""
if [ -f "$HOME/.zshrc" ]; then
    SHELL_FILE="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_FILE="$HOME/.bashrc"
fi

if [ ! -z "$SHELL_FILE" ]; then
    print "Adding ollama alias to $SHELL_FILE..."
    echo 'alias ollama="docker exec -it ollama ollama"' >> "$SHELL_FILE"
    print "To use the ollama command, please run: ${GREEN}source $SHELL_FILE${NC}"
fi

# Wait for services to be ready
print "Waiting for services to be ready..."
sleep 5

# Print success message
print "🚀 Setup complete! You can now:"
echo -e "${GREEN}1.${NC} Access the WebUI at ${GREEN}http://localhost:8080${NC}"
echo -e "${GREEN}2.${NC} Use the ollama command in your terminal (after sourcing your shell config)"
echo -e "${GREEN}3.${NC} Example commands:"
echo -e "   ${BLUE}ollama list${NC}         # List available models"
echo -e "   ${BLUE}ollama pull llama2${NC}  # Download llama2 model"
echo -e "   ${BLUE}ollama run llama2${NC}   # Chat with llama2"
