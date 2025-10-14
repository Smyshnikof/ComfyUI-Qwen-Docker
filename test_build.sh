#!/bin/bash

# Скрипт для тестирования сборки Docker образа ComfyUI-Qwen

set -e

echo "🚀 Тестирование сборки Docker образа ComfyUI-Qwen..."

# Проверяем наличие docker-bake
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен!"
    exit 1
fi

# Проверяем наличие docker-bake
if ! docker buildx version &> /dev/null; then
    echo "❌ Docker Buildx не установлен!"
    exit 1
fi

echo "✅ Docker и Buildx готовы"

# Создаем buildx builder если не существует
echo "🔧 Настройка buildx builder..."
docker buildx create --name qwen-builder --use 2>/dev/null || docker buildx use qwen-builder

# Тестируем сборку с CUDA 12.4 (самая совместимая версия)
echo "🏗️ Сборка образа с CUDA 12.4..."
docker buildx build \
    --platform linux/amd64 \
    --target base-12-4 \
    --tag smyshnikof/comfyui-qwen:test-cu124 \
    --load \
    .

if [ $? -eq 0 ]; then
    echo "✅ Сборка успешна!"
    echo "📦 Образ: smyshnikof/comfyui-qwen:test-cu124"
    
    # Показываем размер образа
    echo "📊 Размер образа:"
    docker images smyshnikof/comfyui-qwen:test-cu124 --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"
    
    # Тестируем запуск контейнера
    echo "🧪 Тестирование запуска контейнера..."
    docker run --rm -d --name qwen-test -p 3000:3000 smyshnikof/comfyui-qwen:test-cu124
    
    # Ждем немного
    sleep 10
    
    # Проверяем статус
    if docker ps | grep -q qwen-test; then
        echo "✅ Контейнер запущен успешно!"
        echo "🌐 ComfyUI должен быть доступен на http://localhost:3000"
    else
        echo "❌ Контейнер не запустился"
        docker logs qwen-test
    fi
    
    # Останавливаем тестовый контейнер
    docker stop qwen-test 2>/dev/null || true
    
else
    echo "❌ Ошибка сборки!"
    exit 1
fi

echo "🎉 Тестирование завершено!"
