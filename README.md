# 🐳 DockerLlama

Your containerized AI companion. DockerLlama brings the power of Ollama to your local environment through Docker, making AI deployment as easy as running a container. Complete with a sleek web interface and CLI tools, all while keeping your data secure in your own infrastructure.

## 🌟 Features

-   🐳 Fully Dockerized setup
-   🎯 Easy-to-use web interface
-   🔒 Secure authentication system
-   🔄 Persistent storage for models and chat history
-   ⚡ High-performance model inference
-   🎨 Modern and intuitive UI

## 📋 Prerequisites

-   Docker
-   Docker Compose
-   8GB RAM minimum (16GB recommended)
-   20GB free disk space

## 🛠️ Quick Start

1. **Clone the repository**

    ```bash
    git clone git@github.com:aze3ma/DockerLlama.git
    cd DockerLlama
    ```

2. **Run the start script**

    ```bash
    ./start.sh
    ```

    This script will:

    - Create `.env` file from `.env.example`
    - Stop any local Ollama instance if running
    - Start Docker services
    - Add `ollama` command alias to your shell
    - Show you next steps

3. **Access the WebUI**
    - Open your browser and navigate to [http://localhost:8080](http://localhost:8080)
    - Create a new account on first access
    - Login with your credentials

## 💻 Usage

### Web Interface

1. **Managing Models**

    - Navigate to the Models tab
    - Click "Download" to get new models
    - Available models include:
        - Llama 2
        - Mistral
        - CodeLlama
        - And many more!

2. **Starting a Chat**

    - Click "New Chat" button
    - Select your preferred model
    - Start chatting!

3. **Adjusting Parameters**
    - Temperature
    - Top P
    - Max tokens
    - And other model-specific settings

### CLI Access

After running `start.sh`, you can use the `ollama` command directly in your terminal:

```bash
# List available models
ollama list

# Pull a new model
ollama pull llama2

# Chat with a model
ollama run llama2
```

## 🔧 Configuration

### Environment Variables

Available options in `.env` file:

-   `OLLAMA_API_BASE_URL`: API endpoint for Ollama
-   `JWT_EXPIRES_IN`: JWT token expiration time (default: 24 hours)
-   `OLLAMA_PORT`: Custom port for Ollama (default: 11434)
-   `WEBUI_PORT`: Custom port for WebUI (default: 8080)

### Volumes

The setup uses Docker volumes for persistence:

-   `ollama_data`: Stores model files
-   `webui_data`: Stores user data and chat history

## 🚨 Troubleshooting

1. **Port Conflicts**

    - Ensure ports 11434 and 8080 are not in use
    - The start script will automatically stop any local Ollama instance

2. **Memory Issues**

    - Increase Docker memory limit
    - Use smaller models if needed

3. **Model Download Issues**
    - Check internet connection
    - Verify disk space availability

## 🔄 Updates

To update to the latest version:

```bash
git pull
docker-compose pull
./start.sh
```

## 🛡️ Security

-   WebUI access is protected by authentication
-   All data is stored locally
-   No external API calls except for model downloads
-   Credentials are stored securely in the database

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## ⭐ Support

If you find this project helpful, please give it a star! For issues and feature requests, use the GitHub issues page.

---

Made with ❤️ by aze3ma
