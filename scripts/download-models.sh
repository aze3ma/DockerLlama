#!/bin/bash
set -e

# Add your preferred models here
MODELS=(
    "llama2"
    "mistral"
    "codellama"
)

for model in "${MODELS[@]}"; do
    echo "Pulling model: $model"
    ollama pull "$model"
done
