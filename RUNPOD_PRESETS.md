> 🎥 Инструкция по пресетам Qwen для RunPod (отдельный файл)

## 🧩 Пресеты и требования к CUDA

- QWEN_IMAGE — (~15GB) генерация изображений (fp8)
- QWEN_EDIT — (~15GB) редактирование изображений (fp8)
- QWEN_IMAGE_BF16 — (~40GB VRAM) генерация изображений (BF16)
- QWEN_EDIT_BF16 — (~40GB VRAM) редактирование изображений (BF16)

Важно:
- Для BF16 пресетов (оба: QWEN_IMAGE_BF16 и QWEN_EDIT_BF16) необходим образ с CUDA 12.8 — тег `cu128`.
- Значение по умолчанию — `cu126`, чтобы запускать лёгкие fp8 пресеты на более бюджетных 30‑й серии GPU.

Рекомендация по образам:
- Лёгкие fp8 пресеты: используйте `smyshnikof/comfyui-qwen:base-torch2.8.0-cu126` (или `cu124` для RTX 3090/3080).
- Полные BF16 пресеты: переключитесь на `smyshnikof/comfyui-qwen:base-torch2.8.0-cu128`.

## 🚀 Как запустить скачивание пресетов

Через веб-загрузчик (порт 8081) — рекомендовано.

Или вручную в JupyterLab:

```bash
# fp8 пресеты (по умолчанию под cu126)
bash /download_presets.sh QWEN_EDIT,QWEN_IMAGE

# BF16 пресеты (ТРЕБУЮТ образ cu128)
bash /download_presets.sh QWEN_IMAGE_BF16,QWEN_EDIT_BF16
```

## 📂 Связанные workflow файлы

- presets/qwen/Qwen-Image/Qwen Image.json (fp8)
- presets/qwen/Qwen-Image/Qwen Image BF16.json (BF16)
- presets/qwen/Qwen-Edit/Qwen Edit Smyshnikov.json (fp8)
- presets/qwen/Qwen-Edit/Qwen Edit BF16.json (BF16)

## ℹ️ Замечания по железу

- BF16 модели стабильнее и качественнее, но требуют ≈40GB VRAM и работают медленнее.
- fp8 модели легче и быстрее; подходят для карт 30‑й серии с меньшей VRAM.


