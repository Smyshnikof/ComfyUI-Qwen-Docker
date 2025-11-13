# 🐳 Docker Build Guide для ComfyUI-Qwen

## 📋 Обзор

Этот проект содержит Docker образы для ComfyUI с поддержкой моделей Qwen. Образы оптимизированы для различных версий CUDA и видеокарт.

## 🏗️ Сборка образов

### Быстрый тест сборки

```powershell
# Windows PowerShell
.\test_build.ps1

# Linux/macOS
./test_build.sh
```

### Сборка всех версий

```powershell
# Windows PowerShell
.\build_all.ps1
```

### Ручная сборка

```bash
# Сборка с CUDA 12.4 (совместимость с RTX 30/40 серии)
docker buildx build --platform linux/amd64 --target base-12-4 --tag smyshnikof/comfyui-qwen:base-torch2.8.0-cu124 --load .

# Сборка с CUDA 12.6 (оптимально для RTX 40 серии)
docker buildx build --platform linux/amd64 --target base-12-6 --tag smyshnikof/comfyui-qwen:base-torch2.8.0-cu126 --load .

# Сборка с CUDA 12.8 (для RTX 50 серии)
docker buildx build --platform linux/amd64 --target base-12-8 --tag smyshnikof/comfyui-qwen:base-torch2.8.0-cu128 --load .

# Сборка с CUDA 12.9 (для новых GPU с CUDA 12.9)
docker buildx build --platform linux/amd64 --target base-12-9 --tag smyshnikof/comfyui-qwen:base-torch2.8.0-cu129 --load .
```

## 🚀 Автоматическая сборка

### GitHub Actions

Проект настроен для автоматической сборки через GitHub Actions:

1. **Триггеры**:
   - Ручной запуск (`workflow_dispatch`)
   - По расписанию (каждые 8 часов)

2. **Версии CUDA**: 12.4, 12.6, 12.8, 12.9

3. **Настройка**:
   - Добавьте `DOCKERHUB_USERNAME` в Variables
   - Добавьте `DOCKERHUB_TOKEN` в Secrets

### Docker Bake

Используйте `docker-bake.hcl` для продвинутой сборки:

```bash
# Сборка всех версий
docker buildx bake

# Сборка конкретной версии
docker buildx bake base-12-4

# Сборка и публикация
docker buildx bake --push
```

## 📦 Доступные образы

| Образ | CUDA | Совместимость | Размер |
|-------|------|---------------|--------|
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu124` | 12.4 | RTX 30/40 серии | ~8GB |
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu126` | 12.6 | RTX 40 серии | ~8GB |
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu128` | 12.8 | RTX 50 серии | ~8GB |
| `smyshnikof/comfyui-qwen:base-torch2.8.0-cu129` | 12.9 | Новые GPU с CUDA 12.9 | ~8GB |

## 🔧 Настройка для разработки

### Локальная разработка

```bash
# Клонируйте репозиторий
git clone https://github.com/smyshnikof/comfyui-qwen-docker.git
cd comfyui-qwen-docker

# Соберите образ
docker buildx build --target base-12-4 --tag comfyui-qwen:local --load .

# Запустите контейнер
docker run -p 3000:3000 -p 8081:8081 comfyui-qwen:local
```

### Тестирование изменений

```bash
# Соберите тестовый образ
docker buildx build --target base-12-4 --tag comfyui-qwen:test --load .

# Запустите с отладкой
docker run -it --rm comfyui-qwen:test /bin/bash
```

## 📋 Требования

- Docker 20.10+
- Docker Buildx
- 20GB+ свободного места
- GPU с поддержкой CUDA (для запуска)

## 🐛 Устранение неполадок

### Ошибки сборки

1. **Недостаточно места**:
   ```bash
   docker system prune -a
   ```

2. **Ошибки CUDA**:
   - Проверьте совместимость версии CUDA с вашей видеокартой
   - Используйте подходящую версию образа

3. **Ошибки памяти**:
   ```bash
   # Увеличьте лимит памяти для Docker
   docker buildx build --memory=8g ...
   ```

### Проверка образа

```bash
# Проверьте размер образа
docker images smyshnikof/comfyui-qwen

# Проверьте содержимое
docker run --rm smyshnikof/comfyui-qwen:base-torch2.8.0-cu124 ls -la /workspace

# Проверьте Python пакеты
docker run --rm smyshnikof/comfyui-qwen:base-torch2.8.0-cu124 pip list
```

## 📚 Дополнительные ресурсы

- [Docker Buildx документация](https://docs.docker.com/buildx/)
- [CUDA совместимость](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/)
- [ComfyUI документация](https://github.com/comfyanonymous/ComfyUI)
