# 🎥 ComfyUI Docker Pod - Полный гайд по использованию

> **Основан на серии роликов по Qwen** от [Егор Смышников](https://www.youtube.com/playlist?list=PLUREBJZfEOoPztQiVSV7vYegAsOtwMiZi)

> 🚀 **Этот Docker образ создан для RunPod, но также работает на вашем локальном компьютере**

---

## 📋 Содержание

1. [🚀 Быстрый старт](#-быстрый-старт)
2. [🔌 Открытые порты](#-открытые-порты)
3. [🏷️ Формат тегов и выбор образа](#️-формат-тегов-и-выбор-образа)
4. [⚙️ Переменные окружения](#️-переменные-окружения)
5. [🔧 Скачивание пресетов Qwen](#-скачивание-пресетов-qwen)
6. [📁 Структура файлов и логи](#-структура-файлов-и-логи)
7. [🌐 Веб-сервисы](#-веб-сервисы)
8. [💻 Работа с JupyterLab](#-работа-с-jupyterlab)
9. [🔧 Продвинутое использование](#-продвинутое-использование)
10. [❓ Решение проблем](#-решение-проблем)

---

## 🚀 Быстрый старт

### 1. Выберите образ
```bash
# RTX 5090/5080 (драйвер 550+)
smyshnikof/comfyui-qwen:base-torch2.8.0-cu128

# RTX 4090/4080 (драйвер 535+)
smyshnikof/comfyui-qwen:base-torch2.8.0-cu126

# RTX 4070/3090/3080 (драйвер 530+)
smyshnikof/comfyui-qwen:base-torch2.8.0-cu124

# Старые драйверы (525 и ниже)
smyshnikof/comfyui-qwen:base-torch2.8.0-cu121
```

### 2. Запустите POD
- Дождитесь полной загрузки (~2-3 минуты)
- Проверьте логи, если что-то пошло не так

### 3. Откройте загрузчик пресетов
```
https://your-pod-id-8081.proxy.runpod.net
```

### 4. Выберите и скачайте нужные пресеты
- **Qwen Edit**: ~15GB (редактирование изображений)
- **Qwen Image**: ~15GB (генерация изображений из текста)

### 5. Откройте ComfyUI
```
https://your-pod-id-3000.proxy.runpod.net
```

### 6. Готово! 🎉
- Модели загружены через удобный веб-интерфейс
- Workflow готовы к использованию
- Начните генерацию!

---

## 🔌 Открытые порты

| Порт | Тип | Сервис | Описание |
| ---- | ---- | ----------- | -------- |
| 22   | TCP  | SSH         | Подключение по SSH |
| 3000 | HTTP | ComfyUI     | Основной интерфейс ComfyUI |
| 8081 | HTTP | Загрузчик пресетов и моделей | Скачивание пресетов Qwen и моделей HuggingFace |
| 8082 | HTTP | CivitAI LoRA downloader | Скачивание LoRA с CivitAI |
| 8083 | HTTP | Обзор результатов | Просмотр и скачивание результатов |
| 8888 | HTTP | JupyterLab  | Интерактивная среда разработки |

---

## 🏷️ Формат тегов и выбор образа

### Формат тегов
```text
smyshnikof/comfyui:(A)-torch2.8.0-(B)
```

- **(A)**: `slim` или `base`
  - `slim`: ComfyUI + Manager + кастомные ноды (без автоскачивания пресетов)
  - `base`: slim + автоскачивание пресетов при запуске
- **(B)**: версия CUDA → `cu124`, `cu126`, `cu128`

### 🧱 Варианты образов

| Имя образа                                 | Кастомные ноды | Пресеты | CUDA | Рекомендуется для |
| ------------------------------------------ | ------------ | ---- | ---- | ----------------- |
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu124`| ✅ Да        | ✅ Да | 12.4 | RTX 4070, 3090, 3080 |
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu126`| ✅ Да        | ✅ Да | 12.6 | RTX 4090, 4080 |
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu128`| ✅ Да        | ✅ Да | 12.8 | RTX 5090, 5080 |
| `smyshnikof/comfyui-qwen:slim-torch2.8.0-cu124`| ✅ Да         | ❌ Нет | 12.4 | Опытные пользователи |
| `smyshnikof/comfyui:slim-torch2.8.0-cu126`| ✅ Да         | ❌ Нет | 12.6 | Опытные пользователи |
| `smyshnikof/comfyui:slim-torch2.8.0-cu128`| ✅ Да         | ❌ Нет | 12.8 | Опытные пользователи |

> 👉 **Для переключения**: Edit Pod/Template → установите `Container Image`

### 🎮 Совместимость с видеокартами

| Видеокарта | Рекомендуемый образ | Примечание |
|------------|-------------------|------------|
| **RTX 5090** | `base-torch2.8.0-cu128` | Оптимальная производительность |
| **RTX 5080** | `base-torch2.8.0-cu128` | Отличная совместимость |
| **RTX 4090** | `base-torch2.8.0-cu126` | Оптимальная производительность |
| **RTX 4080** | `base-torch2.8.0-cu126` | Отличная совместимость |
| **RTX 4070** | `base-torch2.8.0-cu124` | Стабильная работа |
| **RTX 3090** | `base-torch2.8.0-cu124` | Совместимость с Ampere |
| **RTX 3080** | `base-torch2.8.0-cu124` | Совместимость с Ampere |

> ⚠️ **Важно**: Qwen модели оптимизированы для современных GPU и не требуют специальных зависимостей

---

## ⚙️ Переменные окружения

| Переменная                | Описание                                                                | По умолчанию   |
| ----------------------- | -------------------------------------------------------------------------- | --------- |
| `ACCESS_PASSWORD`       | Пароль для JupyterLab & code-server                                      | (не установлен)   |
| `TIME_ZONE`             | [Часовой пояс](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) (например, `Europe/Moscow`)   | `Etc/UTC` |
| `COMFYUI_EXTRA_ARGS`    | Дополнительные опции ComfyUI (например `--fast`)                        | (не установлен)   |
| `PRESET_DOWNLOAD`       | Скачать пресеты моделей при запуске (список через запятую)                  | (не установлен)   |

> 👉 **Для установки**: Edit Pod/Template → Add Environment Variable (Key/Value)


---

## 🔧 Скачивание пресетов Qwen

### Автоматическое скачивание

Установите переменную `PRESET_DOWNLOAD` с нужными пресетами:

```bash
# Один пресет
PRESET_DOWNLOAD=QWEN_EDIT

# Несколько пресетов
PRESET_DOWNLOAD=QWEN_EDIT,QWEN_IMAGE  # ~30GB

# Все пресеты
PRESET_DOWNLOAD=QWEN_EDIT,QWEN_IMAGE  # ~30GB
```

### Ручное скачивание

Через JupyterLab или терминал:

```bash
# Скачать конкретные пресеты
bash /download_presets.sh QWEN_EDIT

# Скачать все пресеты
bash /download_presets.sh QWEN_EDIT,QWEN_IMAGE  # ~30GB

# Тихий режим (без прогресс-бара)
bash /download_presets.sh --quiet QWEN_EDIT
```

### 🎯 Доступные пресеты

| Пресет | Описание | Размер | Время загрузки |
|--------|----------|--------|----------------|
| `QWEN_EDIT` | Qwen Image Edit генерация | ~15GB | 5-10 мин |
| `QWEN_IMAGE` | Qwen Image генерация | ~15GB | 5-10 мин |

### 📁 Расположение файлов

После скачивания пресетов файлы сохраняются в:
- **Модели**: `/workspace/ComfyUI/models/`
- **Workflow**: `/workspace/ComfyUI/user/workflows/Qwen/`
- **LoRA**: `/workspace/ComfyUI/models/loras/`

---

## 📁 Структура файлов и логи

### Основные директории

```
/workspace/
├── ComfyUI/                    # Основная папка ComfyUI
│   ├── models/                 # Модели (diffusion, vae, loras, etc.)
│   ├── user/
│   │   ├── workflows/          # Пользовательские workflow
│   │   └── comfyui_3000.log   # Лог ComfyUI
│   └── output/                 # Результаты генерации
├── logs/                       # Логи всех сервисов
└── .cache/                     # Кэш HuggingFace и pip
```

### 📋 Логи сервисов

| Приложение         | Путь к логу                                   | Описание |
| ----------- | ------------------------------------------ | -------- |
| ComfyUI     | `/workspace/ComfyUI/user/comfyui_3000.log` | Основной лог ComfyUI |
| JupyterLab  | `/workspace/logs/jupyterlab.log`           | Лог JupyterLab |
| CivitAI Downloader | `/workspace/logs/civitai_downloader.log` | Лог скачивания LoRA |
| Outputs Browser | `/workspace/logs/outputs_browser.log` | Лог просмотра результатов |

### Просмотр логов

```bash
# Просмотр лога ComfyUI
tail -f /workspace/ComfyUI/user/comfyui_3000.log

# Просмотр всех логов
tail -f /workspace/logs/*.log

# Поиск ошибок
grep -i error /workspace/logs/*.log
```

---

## 🌐 Веб-сервисы

### 1. ComfyUI (порт 3000)
- **URL**: `https://your-pod-id-3000.proxy.runpod.net`
- **Описание**: Основной интерфейс для генерации
- **Функции**: Загрузка workflow, настройка параметров, генерация

### 2. Загрузчик пресетов и моделей (порт 8081)
- **URL**: `https://your-pod-id-8081.proxy.runpod.net`
- **Описание**: Удобный интерфейс для скачивания пресетов и моделей
- **Функции**:
  - **Пресеты Qwen**: Выберите нужные пресеты и скачайте одним кликом
  - **HuggingFace**: Скачивание моделей с HuggingFace Hub
  - **API токены**: Поддержка токенов для приватных репозиториев
  - **Выбор папки**: Укажите куда сохранить модель

### 3. CivitAI LoRA Downloader (порт 8082)
- **URL**: `https://your-pod-id-8082.proxy.runpod.net`
- **Описание**: Простой интерфейс для скачивания LoRA
- **Использование**:
  1. Получите API токен на [CivitAI](https://civitai.com/settings/tokens)
  2. Введите токен и URL модели
  3. Нажмите "Download"
  4. LoRA автоматически сохранится в `/workspace/ComfyUI/models/loras`

### 4. Обзор результатов (порт 8083)
- **URL**: `https://your-pod-id-8083.proxy.runpod.net`
- **Описание**: Просмотр и скачивание результатов
- **Функции**:
  - Просмотр всех файлов из `/workspace/ComfyUI/output`
  - Скачивание отдельных файлов
  - Скачивание архива со всеми результатами
  - Удобная навигация по папкам

### 5. JupyterLab (порт 8888)
- **URL**: `https://your-pod-id-8888.proxy.runpod.net`
- **Описание**: Интерактивная среда разработки
- **Функции**: Python ноутбуки, терминал, файловый менеджер

---

## 💻 Работа с JupyterLab

### Доступ к JupyterLab

1. Откройте `https://your-pod-id-8888.proxy.runpod.net`
2. Если установлен пароль, введите его
3. Если пароль не установлен, доступ открыт

### Основные функции

#### 1. Терминал
```bash
# Открыть терминал в JupyterLab
# File → New → Terminal

# Проверить статус ComfyUI
ps aux | grep comfyui

# Перезапустить ComfyUI
pkill -f comfyui
cd /ComfyUI && python main.py --listen 0.0.0.0 --port 3000 &
```

#### 2. Управление моделями
```bash
# Скачать дополнительные модели
cd /workspace/ComfyUI/models/diffusion_models
wget "URL_TO_MODEL"

# Установить дополнительные кастомные ноды
cd /ComfyUI/custom_nodes
git clone https://github.com/username/node-name.git
```

#### 3. Python скрипты
```python
# Пример: проверка доступных GPU
import torch
print(f"CUDA доступна: {torch.cuda.is_available()}")
print(f"Количество GPU: {torch.cuda.device_count()}")
print(f"Текущий GPU: {torch.cuda.current_device()}")
print(f"Название GPU: {torch.cuda.get_device_name(0)}")
```

---

## 🔧 Продвинутое использование

### Установка дополнительных кастомных нод

```bash
# Через терминал JupyterLab
cd /ComfyUI/custom_nodes

# Клонировать репозиторий
git clone https://github.com/username/node-name.git

# Установить зависимости
cd node-name
pip install -r requirements.txt

# Перезапустить ComfyUI
pkill -f comfyui
cd /ComfyUI && python main.py --listen 0.0.0.0 --port 3000 &
```

### Настройка переменных окружения

```bash
# Установить переменную через терминал
export COMFYUI_EXTRA_ARGS="--fast --cpu"

# Добавить в .bashrc для постоянного сохранения
echo 'export COMFYUI_EXTRA_ARGS="--fast --cpu"' >> ~/.bashrc
```

### Работа с SSH

```bash
# Подключение по SSH (если настроен PUBLIC_KEY)
ssh root@your-pod-ip

# Копирование файлов
scp local_file.txt root@your-pod-ip:/workspace/
```

### Мониторинг ресурсов

```bash
# Мониторинг GPU
nvidia-smi

# Мониторинг процессов
htop

# Мониторинг дискового пространства
df -h
```

---

## ❓ Решение проблем

### Частые проблемы

#### 1. ComfyUI не запускается
```bash
# Проверить логи
tail -f /workspace/ComfyUI/user/comfyui_3000.log

# Перезапустить ComfyUI
pkill -f comfyui
cd /ComfyUI && python main.py --listen 0.0.0.0 --port 3000 &
```

#### 2. Модели не загружаются
```bash
# Проверить наличие моделей
ls -la /workspace/ComfyUI/models/diffusion_models/

# Переустановить пресеты
bash /download_presets.sh QWEN_EDIT
```

#### 3. Ошибки CUDA
```bash
# Проверить совместимость CUDA
nvidia-smi
python -c "import torch; print(torch.cuda.is_available())"

# Проверить установку PyTorch
python -c "import torch; print(torch.cuda.is_available())"
```

#### 4. Недостаточно места на диске
```bash
# Очистить кэш
rm -rf /workspace/.cache/pip/*
rm -rf /workspace/.cache/huggingface/*

# Удалить ненужные модели
rm /workspace/ComfyUI/models/diffusion_models/unused_model.safetensors
```

### Получение поддержки

1. **Проверьте логи**: `/workspace/logs/`
2. **GitHub Issues**: [Создать issue](https://github.com/somb1/ComfyUI-Docker/issues)
3. **YouTube**: [Канал Егор Смышников](https://www.youtube.com/@smyshnikov)
4. **Discord**: [Сообщество ComfyUI](https://discord.gg/comfyui)

---

## 🧩 Предустановленные компоненты

### Система
- **ОС**: Ubuntu 24.04 (22.02 для CUDA 12.4)
- **Python**: 3.13
- **Фреймворк**: ComfyUI + ComfyUI Manager + JupyterLab + code-server
- **Библиотеки**: PyTorch 2.8.0, CUDA (12.4–12.8), hf_hub, nvtop

### Кастомные ноды (только в образах base и slim)

Полный список: [custom_nodes.txt](https://github.com/Smyshnikof/ComfyUIDocker/blob/main/custom_nodes.txt)

Основные ноды:
- ComfyUI-KJNodes
- ComfyUI-WanVideoWrapper
- ComfyUI-GGUF
- ComfyUI-Easy-Use
- ComfyUI-Frame-Interpolation
- ComfyUI-mxToolkit
- ComfyUI-MultiGPU
- ComfyUI_TensorRT
- ComfyUI_UltimateSDUpscale
- И многие другие...

---

## 🎯 Рекомендации по использованию

### Для новичков
1. Начните с образа `slim` для изучения процесса
2. Устанавливайте пресеты через JupyterLab
3. Изучите интерфейс ComfyUI через порт 3000
4. Используйте готовые workflow из папки `/workspace/ComfyUI/user/workflows/Qwen/`

### Для опытных пользователей
1. Используйте образ `base` с готовыми пресетами для быстрого старта
2. Настраивайте дополнительные кастомные ноды
3. Используйте SSH для удаленного управления
4. Создавайте собственные workflow

### Оптимизация производительности
1. Используйте подходящую версию CUDA для вашей видеокарты
2. Используйте подходящие модели Qwen для ваших задач
3. Настройте `COMFYUI_EXTRA_ARGS` для оптимизации
4. Мониторьте использование ресурсов через `nvidia-smi`

---

*Создано на основе серии роликов [Егор Смышников](https://www.youtube.com/@smyshnikov) по Qwen*
