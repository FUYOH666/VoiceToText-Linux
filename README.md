# 🎙️ VoiceToText-Linux-F9

**Умная система распознавания речи с гибкой конфигурацией!**

🎯 **Одна клавиша для голосового ввода текста** - нажмите F9 и говорите!  
🔧 **Гибкая настройка** - выбирайте модель и язык под свои нужды  
🚀 **Максимальная точность** - Large v3 модель для идеального распознавания  
🇷🇺 **Русский язык** - оптимизировано специально для русской речи

---

## ⚡ Быстрый старт

### ▶️ Базовый запуск:
```bash
cd /home/ai/Документы/dev/VTT-Linux && ./scripts/whisper-toggle.sh
```

### 🔄 Перезапуск системы:
```bash
cd /home/ai/Документы/dev/VTT-Linux && ./scripts/restart.sh
```
*Применяет новые настройки и перезапускает все компоненты (CPU, модель large-v3-turbo-f16)*

### ⚙️ Управление настройками:
```bash
# Переключение модели
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh large-v3-turbo-f16

# Переключение языка
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-language.sh ru

# Перезапуск с новыми настройками
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./restart.sh
```

---

## 📋 Оглавление

- [🚀 Быстрый старт](#-быстрый-старт)
- [⚙️ Конфигурация](#️-конфигурация)
- [🎛️ Управление моделями](#️-управление-моделями)
- [🌍 Управление языками](#-управление-языками)
- [🔄 Перезапуск системы](#-перезапуск-системы)
- [📁 Структура проекта](#-структура-проекта)
- [🛠️ Устранение неисправностей](#️-устранение-неисправностей)
- [📚 Полная документация](#-полная-документация)

---

## ⚙️ Конфигурация

Все настройки хранятся в файле `config.yaml`:

```yaml
# Модель распознавания
model: "large-v3-turbo-f16"  # tiny, base, small, medium, large-v3, large-v3-turbo-f16
model_path: "/home/ai/Документы/dev/VTT-Linux/ggml-large-v3-turbo-f16.bin"

# Язык распознавания
language: "ru"     # ru, en, auto

# Продвинутые настройки
max_context: 0     # Максимальный контекст
max_len: 0        # Максимальная длина
use_gpu: false     # CPU only
cpu_threads: 12    # Используем 12 потоков CPU
extra_params: "--no-fallback"  # Дополнительные параметры
```

### 📝 Рекомендации по выбору модели:

| Модель | Размер | Скорость | Точность | Рекомендация |
|--------|--------|----------|----------|--------------|
| `tiny` | 39MB | ⚡ Очень быстрая | ⭐⭐ | Для тестов |
| `base` | 74MB | ⚡ Быстрая | ⭐⭐⭐ | Баланс |
| `small` | 244MB | 🟡 Средняя | ⭐⭐⭐⭐ | Повышенная точность |
| `medium` | 769MB | 🟡 Средняя | ⭐⭐⭐⭐⭐ | Высокая точность |
| `large-v3` | 2.9GB | 🐌 Медленная | ⭐⭐⭐⭐⭐⭐ | **Максимальная точность (GPU)** |
| `large-v3-turbo-f16` | 1.6GB | 🟡 Средняя | ⭐⭐⭐⭐⭐⭐ | **Оптимальная CPU large (12 потоков)** |

---

## 🎛️ Управление моделями

### 📊 Просмотр доступных моделей:
```bash
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh --list
```

### 🔍 Текущая модель:
```bash
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh --current
```

### 🔄 Переключение модели:
```bash
# На Large v3 Turbo (рекомендуется для русского на CPU)
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh large-v3-turbo-f16

# На Medium (быстрее, но менее точно)
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh medium

# На Base (самая быстрая)
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh base
```

### 📋 Примеры использования:
```bash
# Для максимальной точности русского языка (CPU)
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh large-v3-turbo-f16

# Для быстрой работы
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh base

# Для баланса скорости и точности
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh medium
```

---

## 🌍 Управление языками

### 📊 Просмотр доступных языков:
```bash
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-language.sh --list
```

### 🔍 Текущий язык:
```bash
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-language.sh --current
```

### 🔄 Переключение языка:
```bash
# Русский язык (рекомендуется)
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-language.sh ru

# Английский язык (как было изначально)
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-language.sh en

# Автоопределение языка
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-language.sh auto
```

### 📋 Особенности языков:

| Язык | Описание | Преимущества |
|------|----------|--------------|
| `ru` | Принудительный русский | Максимальная точность для русского |
| `en` | Принудительный английский | Хорошо для английского контента |
| `auto` | Автоопределение | Универсальность, медленнее |

---

## 🔄 Перезапуск системы

### 🚀 Полный перезапуск:
```bash
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./restart.sh
```

### 📋 Что делает перезапуск:
1. ✅ Проверяет конфигурацию
2. ✅ Останавливает все процессы Whisper
3. ✅ Очищает временные файлы
4. ✅ Проверяет доступность модели
5. ✅ Запускает приложение с новыми настройками

### 🎯 Когда нужен перезапуск:
- После изменения модели
- После изменения языка
- После изменения конфигурации
- При проблемах с работой

---

## 📁 Структура проекта

```
📁 /home/ai/Документы/dev/VTT-Linux/          # VoiceToText-Linux-F9
├── ⚙️ config.yaml                                   # Конфигурационный файл
├── 🎛️ scripts/
│   ├── switch-model.sh                             # Управление моделями
│   ├── switch-language.sh                          # Управление языками
│   ├── restart.sh                                  # Перезапуск системы
│   └── whisper-toggle.sh                           # Основной скрипт (CPU)
├── 📚 docs/
│   └── SETUP_GUIDE.md                              # Подробная установка
├── 📖 README.md                                    # Эта документация
└── ggml-large-v3-turbo-f16.bin                     # Локальная модель

📁 /home/ai/Projects/whisper.cpp/                    # Whisper.cpp (исходники)
├── build-cpu/bin/whisper-cli                      # CPU бинарь
└── models/                                         # Полный набор моделей
    ├── 🏆 ggml-large-v3.bin                        # Large v3 (2.9GB) - активная
    ├── 🥈 ggml-medium.bin                          # Medium (1.5GB)
    ├── 🥉 ggml-base.bin                            # Base (142MB)
    └── 🧪 ggml-tiny.bin                            # Tiny (39MB) - для тестов
```

### 💡 Управление моделями

**📍 Расположение:** `/home/ai/Projects/whisper.cpp/models/`

**📊 Текущие модели:**
- 🏆 **Large v3**: 2.9GB (активная, максимальная точность)
- 🥈 **Medium**: 1.5GB (высокая точность, баланс)
- 🥉 **Base**: 142MB (быстрая, средняя точность)
- 🧪 **Tiny**: 39MB (тестовая, низкая точность)

**🔧 Команды управления:**
```bash
# Просмотр доступных моделей
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh --list

# Проверить доступные модели в исходниках
cd /home/ai/Projects/whisper.cpp/models && ls -lh

# Скачать новую модель
cd /home/ai/Projects/whisper.cpp && bash ./models/download-ggml-model.sh small

# Переключить модель
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh medium
```

---

## 🛠️ Устранение неисправностей

### 🚨 Проблема: F9 не работает
```bash
# Проверить горячую клавишу
gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome.settings-daemon.plugins/media-keys/custom-keybindings/custom0/ command

# Перезагрузить GNOME
Alt+F2 → r → Enter
```

### 🚨 Проблема: Модель не найдена
```bash
# Проверить доступные модели
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh --list

# Скачать нужную модель (из исходников whisper.cpp)
cd /home/ai/Projects/whisper.cpp && bash ./models/download-ggml-model.sh large-v3-turbo-f16
```

### 🚨 Проблема: Русский текст на английском
```bash
# Проверить текущий язык
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-language.sh --current

# Переключить на русский
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-language.sh ru

# Перезапустить
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./restart.sh
```

### 🚨 Проблема: Система зависла
```bash
# Принудительная очистка
pkill -9 -f arecord
pkill -9 -f "whisper-cli"
pkill -9 -f "whisper-toggle.sh"
rm -rf /tmp/whisper-recordings/
rm -f /tmp/whisper-recording.pid

# Перезапуск
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./restart.sh
```

---

## 📚 Полная документация

### 🎯 Основные команды:
```bash
# Запуск
cd /home/ai/Документы/dev/VTT-Linux && ./scripts/whisper-toggle.sh

# Управление
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh --help
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-language.sh --help
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./restart.sh
```

### ⚙️ Конфигурация (config.yaml):
- `model`: Модель Whisper (tiny, base, small, medium, large-v3)
- `language`: Язык (ru, en, auto)
- `max_context`: Максимальный контекст (0 = без ограничений)
- `max_len`: Максимальная длина (0 = без ограничений)
- `extra_params`: Дополнительные параметры (--no-fallback)

### 🔧 Системные требования:
- Ubuntu/Debian Linux
- Python 3.8+
- FFmpeg (для обработки аудио)
- PulseAudio или ALSA
- Минимум 4GB RAM (8GB+ рекомендуется)
- Для Large v3: 16GB+ RAM рекомендуется

---

## 🎉 Быстрые команды для копирования:

```bash
# 🚀 Запуск
cd /home/ai/Документы/dev/VTT-Linux && ./scripts/whisper-toggle.sh

# 🔄 Переключение на максимальную точность (CPU)
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh large-v3-turbo-f16 && ./switch-language.sh ru && ./restart.sh

# ⚡ Переключение на быструю работу
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./switch-model.sh base && ./switch-language.sh auto && ./restart.sh

# 🛑 Полная очистка и перезапуск
cd /home/ai/Документы/dev/VTT-Linux/scripts && ./restart.sh
```

---

## 📞 Поддержка

Если возникли вопросы:
1. Проверьте эту документацию
2. Используйте команды диагностики
3. При необходимости обратитесь за помощью

**Наслаждайтесь VoiceToText-Linux-F9!** 🎙️✨
