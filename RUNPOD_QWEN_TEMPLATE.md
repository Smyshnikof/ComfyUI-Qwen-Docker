> 🎥 **Template основан на серии роликов по Qwen** от [Егор Смышников Плейлист](https://www.youtube.com/playlist?list=PLUREBJZfEOoPztQiVSV7vYegAsOtwMiZi)

## 🔌 Открытые порты

| Порт | Тип | Сервис |
| ---- | ---- | ----------- |
| 22   | TCP  | SSH         |
| 3000 | HTTP | ComfyUI     |
| 8081 | HTTP | Загрузчик пресетов и моделей |
| 8082 | HTTP | CivitAI LoRA downloader |
| 8083 | HTTP | Обзор и скачивание output |
| 8888 | HTTP | JupyterLab  |

---

## 🏷️ Формат тегов

```text
smyshnikof/comfyui-qwen:base-torch2.8.0-cu128
```

* **base**: ComfyUI + Manager + кастомные ноды + веб-загрузчик пресетов
* **torch2.8.0**: PyTorch версия
* **cu128**: CUDA версия (cu124, cu126, cu128)

---

## 🧱 Варианты образов

| Имя образа                                 | Кастомные ноды | Веб-загрузчик | CUDA |
| ------------------------------------------ | ------------ | ---- | ---- |
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu124`| ✅ Да         | ✅ Да  | 12.4 |
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu126`| ✅ Да         | ✅ Да  | 12.6 |
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu128`| ✅ Да         | ✅ Да  | 12.8 |

> 👉 Для переключения: **Edit Pod/Template** → установите `Container Image`.

---

## ⚙️ Переменные окружения

| Переменная                | Описание                                                                | По умолчанию   |
| ----------------------- | -------------------------------------------------------------------------- | --------- |
| `ACCESS_PASSWORD`       | Пароль для JupyterLab & code-server                                      | (авто)   |
| `TIME_ZONE`             | [Часовой пояс](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) (например, `Asia/Seoul`)   | `Etc/UTC` |
| `COMFYUI_EXTRA_ARGS`    | Дополнительные опции ComfyUI (например `--fast`)                        | (не установлен)   |

> 👉 Для установки: **Edit Pod/Template** → **Add Environment Variable** (Key/Value).


> 🎯 **Этот template идеально подходит для видеокарт 40 и 50 серии**

---

## 🚀 Быстрый старт

### 1. Выберите образ
```
smyshnikof/comfyui-qwen:base-torch2.8.0-cu128
```
```
smyshnikof/comfyui-qwen:base-torch2.8.0-cu126
```
```
smyshnikof/comfyui-qwen:base-torch2.8.0-cu124
```

### 2. Запустите POD
- Дождитесь полной загрузки (~2-3 минуты)

### 3. Откройте загрузчик пресетов
```
https://your-pod-id-8081.proxy.runpod.net
```

### 4. Выберите и скачайте нужные пресеты
- **Qwen Image (fp8)**: ~15GB — пресет `QWEN_IMAGE`
- **Qwen Edit (fp8)**: ~15GB — пресет `QWEN_EDIT`
- **Qwen Image (BF16)**: требуется ~40GB — пресет `QWEN_IMAGE_BF16` (нужен образ `cu128`)
- **Qwen Edit (BF16)**: требуется ~40GB — пресет `QWEN_EDIT_BF16` (нужен образ `cu128`)

### 5. Откройте ComfyUI
```
https://your-pod-id-3000.proxy.runpod.net
```

---

## 🔧 Скачивание пресетов (Qwen)

> **Рекомендуется**: Используйте веб-загрузчик (порт 8081) для удобного скачивания пресетов.

> **Альтернативно**: Можно вручную запустить скрипт в JupyterLab:

```bash
bash /download_presets.sh QWEN_EDIT,QWEN_IMAGE
```

### Qwen пресеты (встроенные workflow)

- `QWEN_EDIT` - (~15GB) - Qwen Image Edit генерация
- `QWEN_IMAGE` - (~15GB) - Qwen Image генерация

---

## 📁 Логи

| Приложение         | Путь к логу                                   |
| ----------- | ------------------------------------------ |
| ComfyUI     | `/workspace/ComfyUI/user/comfyui_3000.log` |
| JupyterLab  | `/workspace/logs/jupyterlab.log`           |
| Preset Downloader | `/workspace/logs/preset_downloader.log` |
| CivitAI Downloader | `/workspace/logs/civitai_downloader.log` |
| Outputs Browser | `/workspace/logs/outputs_browser.log` |

---

## 🧩 Предустановленные компоненты

### Система

* **ОС**: Ubuntu 24.04 (22.02 для CUDA 12.4)
* **Python**: 3.13
* **Фреймворк**: [ComfyUI](https://github.com/comfyanonymous/ComfyUI) + [ComfyUI Manager](https://github.com/Comfy-Org/ComfyUI-Manager) + [JupyterLab](https://jupyter.org/)
* **Библиотеки**: PyTorch 2.8.0, CUDA (12.4–12.8), [hf_hub](https://huggingface.co/docs/huggingface_hub), [nvtop](https://github.com/Syllo/nvtop)

#### Кастомные ноды (в образе **base**)

Полный список: https://github.com/Smyshnikof/ComfyUIDocker/blob/main/custom_nodes.txt

---

## 🌐 Веб-сервисы

### Загрузчик пресетов и моделей (порт 8081)
- Скачивание пресетов Qwen по нажатию кнопки
- Скачивание моделей с HuggingFace
- Поддержка API токенов для приватных репозиториев
- Выбор папки назначения для моделей

### CivitAI LoRA Downloader (порт 8082)
- Простой интерфейс для скачивания LoRA с CivitAI
- Введите API токен и URL модели
- Автоматически сохраняет в `/workspace/ComfyUI/models/loras`

### Обзор результатов (порт 8083)  
- Просмотр всех файлов из `/workspace/ComfyUI/output`
- Скачивание отдельных файлов или архива со всеми результатами
- Удобная навигация по папкам

---

## 🧩 Qwen пресеты и CUDA требования (дополнение)

- `QWEN_IMAGE_BF16` — (~40GB) генерация изображений (BF16)
- `QWEN_EDIT_BF16` — (~40GB) редактирование изображений (BF16)

**Важно:** BF16 пресеты требуют образ с CUDA 12.8 → используйте тег `cu128`.

По умолчанию для экономии — `cu126`, чтобы запускать лёгкие fp8 пресеты на доступных GPU 30‑й серии.

Примеры запуска:
```bash
# fp8 (дефолт, cu126)
bash /download_presets.sh QWEN_EDIT,QWEN_IMAGE

# BF16 (нужен образ cu128)
bash /download_presets.sh QWEN_IMAGE_BF16,QWEN_EDIT_BF16
```


