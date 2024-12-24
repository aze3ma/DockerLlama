#!/bin/bash
# setup-volumes.sh

# Create main volumes directory
mkdir -p volumes/{ollama,webui}

# Ollama volumes
mkdir -p volumes/ollama/{models,config,libraries,data}

# WebUI volumes
mkdir -p volumes/webui/{data,config,logs,persistent}

# Set proper permissions
chmod -R 755 volumes/
