# 🚀 GitHub Actions Setup для ComfyUI-Qwen

## 📋 Настройка автоматической сборки

### 1. Настройка Secrets и Variables

Перейдите в настройки репозитория: `https://github.com/Smyshnikof/ComfyUI-Qwen-Docker/settings`

#### Variables (Settings → Secrets and variables → Actions → Variables):
- `DOCKERHUB_USERNAME`: `Smyshnikof`

#### Secrets (Settings → Secrets and variables → Actions → Secrets):
- `DOCKERHUB_TOKEN`: [Ваш токен Docker Hub](https://hub.docker.com/settings/security)

### 2. Создание Docker Hub токена

1. Перейдите на [Docker Hub](https://hub.docker.com/settings/security)
2. Нажмите "New Access Token"
3. Название: `comfyui-qwen-github-actions`
4. Права: `Read, Write, Delete`
5. Скопируйте токен и добавьте в GitHub Secrets

### 3. Проверка GitHub Actions

После настройки secrets:

1. Перейдите в [Actions](https://github.com/Smyshnikof/ComfyUI-Qwen-Docker/actions)
2. Найдите workflow "Build and Push Docker Images"
3. Нажмите "Run workflow" для ручного запуска
4. Или дождитесь автоматического запуска (каждые 8 часов)

## 🏗️ Сборка образов

### Автоматическая сборка

GitHub Actions будет собирать следующие образы:

- `smyshnikof/comfyui-qwen:base-torch2.8.0-cu124`
- `smyshnikof/comfyui-qwen:base-torch2.8.0-cu126` 
- `smyshnikof/comfyui-qwen:base-torch2.8.0-cu128`

### Ручная сборка

```bash
# Локальная сборка
docker buildx build --platform linux/amd64 --target base-12-4 --tag smyshnikof/comfyui-qwen:base-torch2.8.0-cu124 --load .

# Публикация в Docker Hub
docker push smyshnikof/comfyui-qwen:base-torch2.8.0-cu124
```

## 📊 Мониторинг сборки

### Проверка статуса

1. **GitHub Actions**: https://github.com/Smyshnikof/ComfyUI-Qwen-Docker/actions
2. **Docker Hub**: https://hub.docker.com/r/smyshnikof/comfyui-qwen/tags

### Логи сборки

В GitHub Actions вы можете:
- Просматривать логи каждого шага
- Скачивать артефакты сборки
- Перезапускать failed jobs

## 🔧 Настройка для RunPod

### Создание Template

1. Перейдите в [RunPod Console](https://runpod.io/console/pods)
2. Создайте новый Template:
   - **Name**: `ComfyUI-Qwen`
   - **Container Image**: `smyshnikof/comfyui-qwen:base-torch2.8.0-cu128`
   - **Container Disk**: `50 GB`

### Переменные окружения

```env
PRESET_DOWNLOAD=QWEN_EDIT,QWEN_IMAGE
ACCESS_PASSWORD=your_password
TIME_ZONE=Europe/Moscow
```

## 🧪 Тестирование

### Локальное тестирование

```powershell
# Windows
.\test_build.ps1

# Linux/macOS  
./test_build.sh
```

### Тестирование на RunPod

1. Создайте Pod с новым образом
2. Откройте загрузчик пресетов: `https://your-pod-id-8081.proxy.runpod.net`
3. Скачайте пресеты QWEN_EDIT и QWEN_IMAGE
4. Откройте ComfyUI: `https://your-pod-id-3000.proxy.runpod.net`

## 📚 Полезные ссылки

- [GitHub Actions документация](https://docs.github.com/en/actions)
- [Docker Hub документация](https://docs.docker.com/docker-hub/)
- [RunPod документация](https://docs.runpod.io/)
- [ComfyUI документация](https://github.com/comfyanonymous/ComfyUI)
