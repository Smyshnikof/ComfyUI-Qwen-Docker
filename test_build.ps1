# Скрипт для тестирования сборки Docker образа ComfyUI-Qwen

Write-Host "🚀 Тестирование сборки Docker образа ComfyUI-Qwen..." -ForegroundColor Green

# Проверяем наличие docker
try {
    $dockerVersion = docker --version
    Write-Host "✅ Docker найден: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker не установлен!" -ForegroundColor Red
    exit 1
}

# Проверяем наличие docker buildx
try {
    $buildxVersion = docker buildx version
    Write-Host "✅ Docker Buildx найден" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker Buildx не установлен!" -ForegroundColor Red
    exit 1
}

# Создаем buildx builder если не существует
Write-Host "🔧 Настройка buildx builder..." -ForegroundColor Yellow
try {
    docker buildx create --name qwen-builder --use 2>$null
    Write-Host "✅ Builder создан" -ForegroundColor Green
} catch {
    docker buildx use qwen-builder
    Write-Host "✅ Builder уже существует" -ForegroundColor Green
}

# Тестируем сборку с CUDA 12.4
Write-Host "🏗️ Сборка образа с CUDA 12.4..." -ForegroundColor Yellow
try {
    docker buildx build --platform linux/amd64 --target base-12-4 --tag smyshnikof/comfyui-qwen:test-cu124 --load .
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Сборка успешна!" -ForegroundColor Green
        Write-Host "📦 Образ: smyshnikof/comfyui-qwen:test-cu124" -ForegroundColor Cyan
        
        # Показываем размер образа
        Write-Host "📊 Размер образа:" -ForegroundColor Yellow
        docker images smyshnikof/comfyui-qwen:test-cu124 --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"
        
        # Тестируем запуск контейнера
        Write-Host "🧪 Тестирование запуска контейнера..." -ForegroundColor Yellow
        docker run --rm -d --name qwen-test -p 3000:3000 smyshnikof/comfyui-qwen:test-cu124
        
        # Ждем немного
        Start-Sleep -Seconds 10
        
        # Проверяем статус
        $containerStatus = docker ps --filter "name=qwen-test" --format "{{.Names}}"
        if ($containerStatus -eq "qwen-test") {
            Write-Host "✅ Контейнер запущен успешно!" -ForegroundColor Green
            Write-Host "🌐 ComfyUI должен быть доступен на http://localhost:3000" -ForegroundColor Cyan
        } else {
            Write-Host "❌ Контейнер не запустился" -ForegroundColor Red
            docker logs qwen-test
        }
        
        # Останавливаем тестовый контейнер
        docker stop qwen-test 2>$null
        
    } else {
        Write-Host "❌ Ошибка сборки!" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Ошибка при сборке: $_" -ForegroundColor Red
    exit 1
}

Write-Host "🎉 Тестирование завершено!" -ForegroundColor Green
