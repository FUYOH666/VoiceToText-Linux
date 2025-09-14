#!/bin/bash

# VoiceToText-Linux-F9: Restart Script
# Полный перезапуск приложения с новой конфигурацией

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функция для вывода цветного текста
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${YELLOW}[STEP]${NC} $1"
}

echo "VoiceToText-Linux-F9: Полный перезапуск системы"
echo "=============================================="

# Шаг 1: Проверка конфигурации
print_step "1. Проверка конфигурации..."
CONFIG_FILE="/home/ai/Документы/dev/whisper-Linux-EN/config.yaml"
if [ ! -f "$CONFIG_FILE" ]; then
    print_error "Конфигурационный файл не найден: $CONFIG_FILE"
    exit 1
fi

# Чтение текущих настроек
CURRENT_MODEL=$(grep "^model:" "$CONFIG_FILE" | cut -d':' -f2 | sed 's/ *//g; s/"//g')
CURRENT_LANG=$(grep "^language:" "$CONFIG_FILE" | cut -d':' -f2 | sed 's/ *//g; s/"//g')

print_info "Текущая модель: $CURRENT_MODEL"
print_info "Текущий язык: $CURRENT_LANG"

# Шаг 2: Остановка всех процессов
print_step "2. Остановка всех процессов Whisper..."
pkill -9 -f arecord 2>/dev/null
pkill -9 -f "whisper-cli" 2>/dev/null
pkill -9 -f "whisper-toggle.sh" 2>/dev/null

# Проверка остановки
sleep 2
if ps aux | grep -E "(whisper|arecord)" | grep -v grep > /dev/null; then
    print_warning "Некоторые процессы всё ещё работают, принудительная остановка..."
    pkill -9 -f arecord 2>/dev/null
    pkill -9 -f "whisper-cli" 2>/dev/null
    pkill -9 -f "whisper-toggle.sh" 2>/dev/null
    sleep 1
fi

print_success "Все процессы остановлены"

# Шаг 3: Очистка временных файлов
print_step "3. Очистка временных файлов..."
rm -rf /tmp/whisper-recordings/ 2>/dev/null
rm -f /tmp/whisper-recording.pid 2>/dev/null
print_success "Временные файлы очищены"

# Шаг 4: Проверка модели
print_step "4. Проверка доступности модели..."
MODEL_FILE="/home/ai/Projects/whisper.cpp/models/ggml-${CURRENT_MODEL}.bin"
if [ ! -f "$MODEL_FILE" ]; then
    print_error "Модель '$CURRENT_MODEL' не найдена: $MODEL_FILE"
    print_info "Используйте: /home/ai/Документы/dev/whisper-Linux-EN/scripts/switch-model.sh --list"
    exit 1
fi

MODEL_SIZE=$(ls -lh "$MODEL_FILE" | awk '{print $5}')
print_success "Модель найдена: $MODEL_SIZE"

# Шаг 5: Запуск с новой конфигурацией
print_step "5. Запуск приложения с новой конфигурацией..."
print_info "Команда: cd /home/ai/Projects/whisper.cpp && ./whisper-toggle.sh"

# Небольшая пауза для подготовки
sleep 1

# Показать статус
echo ""
print_success "🎉 ПЕРЕЗАПУСК ЗАВЕРШЕН!"
echo ""
print_info "Текущие настройки:"
print_info "  Модель: $CURRENT_MODEL"
print_info "  Язык: $CURRENT_LANG"
echo ""
print_info "Приложение готово к работе!"
print_info "Нажмите F9 для запуска записи голоса"

# Предложить протестировать
echo ""
print_warning "Хотите протестировать? Нажмите F9 или используйте:"
echo "cd /home/ai/Projects/whisper.cpp && ./whisper-toggle.sh"
