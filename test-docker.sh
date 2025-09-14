#!/bin/bash

# VoiceToText-Linux Docker Test Script
# Тестирует сборку Docker образа

echo "🧪 Тестирование Docker сборки для VoiceToText-Linux"
echo "================================================="

# Проверка наличия Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не найден. Установите Docker Desktop или Docker Engine"
    exit 1
fi

echo "✅ Docker найден"

# Проверка наличия Dockerfile
if [ ! -f "Dockerfile" ]; then
    echo "❌ Dockerfile не найден в текущей директории"
    exit 1
fi

echo "✅ Dockerfile найден"

# Сборка образа
echo "🏗️ Сборка Docker образа (это может занять несколько минут)..."
if docker build -t voicetotext-linux-test .; then
    echo "✅ Образ успешно собран!"
else
    echo "❌ Ошибка сборки образа"
    exit 1
fi

# Проверка что образ создан
if docker images | grep -q voicetotext-linux-test; then
    echo "✅ Образ 'voicetotext-linux-test' создан"
else
    echo "❌ Образ не найден после сборки"
    exit 1
fi

# Показать информацию об образе
echo ""
echo "📊 Информация об образе:"
docker images voicetotext-linux-test

# Тестовый запуск (без интерактивного режима)
echo ""
echo "🚀 Тестовый запуск контейнера..."
if docker run --rm voicetotext-linux-test echo "VoiceToText-Linux container is working!"; then
    echo "✅ Контейнер запускается корректно!"
else
    echo "❌ Проблемы с запуском контейнера"
    exit 1
fi

# Проверка что модели загружены
echo ""
echo "🧠 Проверка моделей..."
docker run --rm voicetotext-linux-test ls -la /app/whisper.cpp/models/ | grep ggml

echo ""
echo "🎉 Все тесты пройдены! Docker образ готов к использованию."
echo ""
echo "Для запуска используйте:"
echo "  ./docker-run.sh"
echo ""
echo "Для удаления тестового образа:"
echo "  docker rmi voicetotext-linux-test"
