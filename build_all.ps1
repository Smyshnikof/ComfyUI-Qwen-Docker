# Скрипт для сборки всех версий Docker образа ComfyUI-Qwen

Write-Host "🚀 Сборка всех версий Docker образа ComfyUI-Qwen..." -ForegroundColor Green

# Проверяем наличие docker
try {
    $dockerVersion = docker --version
    Write-Host "✅ Docker найден: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker не установлен!" -ForegroundColor Red
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

# Список версий для сборки
$versions = @("12-4", "12-6", "12-8")

foreach ($version in $versions) {
    Write-Host "🏗️ Сборка образа с CUDA $version..." -ForegroundColor Yellow
    
    try {
        docker buildx build --platform linux/amd64 --target "base-$version" --tag "smyshnikof/comfyui-qwen:base-torch2.8.0-cu$($version.Replace('-', ''))" --load .
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Сборка CUDA $version успешна!" -ForegroundColor Green
        } else {
            Write-Host "❌ Ошибка сборки CUDA $version!" -ForegroundColor Red
        }
    } catch {
        Write-Host "❌ Ошибка при сборке CUDA $version: $_" -ForegroundColor Red
    }
}

Write-Host "📊 Список собранных образов:" -ForegroundColor Yellow
docker images smyshnikof/comfyui-qwen --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"

Write-Host "🎉 Сборка завершена!" -ForegroundColor Green
Write-Host "💡 Для публикации в Docker Hub используйте: docker push smyshnikof/comfyui-qwen:base-torch2.8.0-cu124" -ForegroundColor Cyan
