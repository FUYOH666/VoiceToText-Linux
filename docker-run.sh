#!/bin/bash

# VoiceToText-Linux Docker Runner
# Quick start script for Docker deployment

echo "🎙️ VoiceToText-Linux Docker Edition"
echo "=================================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен. Установите Docker: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker daemon is running
if ! docker info &> /dev/null; then
    echo "❌ Docker daemon не запущен. Запустите Docker Desktop или systemctl start docker"
    exit 1
fi

echo "✅ Docker готов к работе"

# Create recordings directory
mkdir -p recordings

# Build and run container
echo "🏗️ Сборка Docker образа..."
docker build -t voicetotext-linux .

echo "🚀 Запуск контейнера..."
docker run -it --rm \
    --name voicetotext-linux \
    --volume "$(pwd)/recordings:/tmp/whisper-recordings" \
    --volume "/tmp/.X11-unix:/tmp/.X11-unix" \
    --env DISPLAY=$DISPLAY \
    --device /dev/snd \
    voicetotext-linux

echo "✅ Контейнер запущен! Используйте скрипты в директории /app/voicetotext-linux/"
