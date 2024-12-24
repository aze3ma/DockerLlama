#!/bin/bash
set -e

echo "Installing Ollama..."
curl https://ollama.ai/install.sh | sh

echo "Checking Ollama installation..."
if command -v ollama >/dev/null 2>&1; then
    echo "Ollama installed successfully!"
    echo "Starting Ollama service..."
    ollama serve &
    sleep 5
    echo "You can now use Ollama! Try:"
    echo "ollama pull llama2"
    echo "ollama run llama2"
else
    echo "Error: Ollama installation failed"
    exit 1
fi
