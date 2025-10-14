# 🔧 CUDA Совместимость для ComfyUI-Qwen

## ⚠️ Важно: Выбор правильного образа

### 🎯 **Для RTX 3090 используйте:**
```bash
smyshnikof/comfyui-qwen:base-torch2.8.0-cu124
```

**НЕ используйте** `cu128` - это только для RTX 50 серии!

## 📊 Таблица совместимости

| Видеокарта | Рекомендуемый образ | CUDA | Драйвер |
|------------|-------------------|------|---------|
| **RTX 5090/5080** | `base-torch2.8.0-cu128` | 12.8 | 550+ |
| **RTX 4090/4080** | `base-torch2.8.0-cu126` | 12.6 | 535+ |
| **RTX 4070** | `base-torch2.8.0-cu124` | 12.4 | 535+ |
| **RTX 3090/3080** | `base-torch2.8.0-cu124` | 12.4 | 535+ |
| **RTX 3070/3060** | `base-torch2.8.0-cu124` | 12.4 | 535+ |

## 🚨 Частые ошибки

### Ошибка: "cuda>=12.8, please update your driver"
```
nvidia-container-cli: requirement error: unsatisfied condition: cuda>=12.8
```

**Решение:** Используйте образ с CUDA 12.4:
```bash
# ❌ Неправильно для RTX 3090
smyshnikof/comfyui-qwen:base-torch2.8.0-cu128

# ✅ Правильно для RTX 3090
smyshnikof/comfyui-qwen:base-torch2.8.0-cu124
```

## 🔍 Проверка совместимости

### Проверка драйвера NVIDIA
```bash
nvidia-smi
```

### Проверка поддерживаемой версии CUDA
```bash
nvidia-smi | grep "CUDA Version"
```

## 🛠️ Настройка на RunPod

### 1. Создание Template
- **Name**: `ComfyUI-Qwen-RTX3090`
- **Container Image**: `smyshnikof/comfyui-qwen:base-torch2.8.0-cu124`
- **Container Disk**: `50 GB`

### 2. Переменные окружения
```env
PRESET_DOWNLOAD=QWEN_EDIT,QWEN_IMAGE
ACCESS_PASSWORD=your_password
TIME_ZONE=Europe/Moscow
```

## 📋 Быстрые команды

### Для RTX 3090/3080:
```bash
# RunPod Template
smyshnikof/comfyui-qwen:base-torch2.8.0-cu124

# Локальная сборка
docker buildx build --target base-12-4 --tag comfyui-qwen:rtx3090 --load .
```

### Для RTX 4090/4080:
```bash
# RunPod Template
smyshnikof/comfyui-qwen:base-torch2.8.0-cu126

# Локальная сборка
docker buildx build --target base-12-6 --tag comfyui-qwen:rtx4090 --load .
```

### Для RTX 5090/5080:
```bash
# RunPod Template
smyshnikof/comfyui-qwen:base-torch2.8.0-cu128

# Локальная сборка
docker buildx build --target base-12-8 --tag comfyui-qwen:rtx5090 --load .
```

## 🆘 Устранение неполадок

### 1. Ошибка совместимости CUDA
- Проверьте версию драйвера: `nvidia-smi`
- Используйте подходящий образ из таблицы выше

### 2. Контейнер не запускается
- Убедитесь, что используете правильный образ
- Проверьте логи: `docker logs <container_name>`

### 3. Медленная работа
- Используйте образ с подходящей версией CUDA
- Проверьте, что GPU используется: `nvidia-smi`

## 📚 Дополнительные ресурсы

- [NVIDIA CUDA Compatibility](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/)
- [Docker NVIDIA Runtime](https://docs.docker.com/config/containers/resource_constraints/#gpu)
- [RunPod GPU Types](https://docs.runpod.io/references/gpu-types)
