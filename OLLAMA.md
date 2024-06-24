# ollama

## ollama pull
- sudo podman pull docker.io/ollama/ollama:latest
- sudo podman pull ghcr.io/open-webui/open-webui:latest
- sudo podman pull docker.io/cloudflare/cloudflared:latest

## ollama create
- sudo podman create --interactive --tty --oom-score-adj 1000 --init --name LLM-ollama --replace --device=nvidia.com/gpu=0 --volume ollama-models:/root/.ollama/models docker.io/ollama/ollama
- sudo podman create --interactive --tty --oom-score-adj 1000 --init --name LLM-openwebui --replace --env OLLAMA_BASE_URL=http://LLM-ollama:11434 ghcr.io/open-webui/open-webui
- sudo podman create --interactive --tty --oom-score-adj 1000 --init --name LLM-https --replace docker.io/cloudflare/cloudflared tunnel --url http://LLM-openwebui:8080

## ollama start
- sudo podman container start LLM-ollama
- sudo podman container start LLM-openwebui
- sudo podman container start LLM-https
- sudo podman container logs LLM-https

## ollama pull model
- sudo podman exec --interactive --tty LLM-ollama ollama pull llama3:8b-instruct-q5_K_M
- sudo podman exec --interactive --tty LLM-ollama ollama pull gemma:7b-instruct-v1.1-q5_K_M
- sudo podman exec --interactive --tty LLM-ollama ollama pull mistral:7b-instruct-v0.3-q5_K_M
- sudo podman exec --interactive --tty LLM-ollama ollama pull qwen2:7b-instruct-q5_K_M
- sudo podman exec --interactive --tty LLM-ollama ollama pull phi3:14b-medium-4k-instruct-q5_K_M
