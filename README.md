# 🐳 LlamaBase

A simple Docker setup for running Ollama locally with a web interface. Run AI models on your own machine, with your data staying private and secure.

## 🚀 Quick Start

```bash
# Clone and enter the repository
git clone git@github.com:aze3ma/LlamaBase.git
cd LlamaBase

# Start everything with one command
./start.sh
```

That's it! The script will set up everything you need.

## 📋 Requirements

-   Docker
-   Docker Compose
-   8GB RAM (16GB recommended)
-   20GB disk space

## 🎯 What You Get

-   Web interface at http://localhost:8080
-   Command-line access via `ollama` command
-   Your choice of AI models (llama2, mistral, etc.)
-   All data stored locally on your machine

## 💻 Basic Usage

### Web Interface

1. Open http://localhost:8080
2. Create an account
3. Start chatting!

### Command Line

```bash
# List your models
ollama list

# Chat with a model
ollama run mistral
```

## 🔧 Troubleshooting

If something goes wrong:

1. Check Docker logs: `docker logs ollama`
2. Restart services: `docker-compose restart`
3. Make sure ports 11434 and 8080 are free

## 📝 License

MIT License

---

Made with ❤️ by aze3ma
