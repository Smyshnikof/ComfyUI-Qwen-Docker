#!/bin/bash

WGET_OPTS="--show-progress"

if [[ "$1" == "--quiet" ]]; then
    WGET_OPTS="-q"
    shift
fi

# download_if_missing <URL> <TARGET_DIR>
download_if_missing() {
    local url="$1"
    local dest_dir="$2"

    local filename
    filename=$(basename "$url")
    # Убираем query-параметры из имени файла (например, ?download=true)
    filename="${filename%%\?*}"
    local filepath="$dest_dir/$filename"

    mkdir -p "$dest_dir"

    if [ -f "$filepath" ]; then
        echo "File already exists: $filepath (skipping)"
        return
    fi

    echo "Downloading: $filename → $dest_dir"
    
    local tmpdir="/workspace/tmp"
    mkdir -p "$tmpdir"
    local tmpfile="$tmpdir/${filename}.part"

    if wget $WGET_OPTS -O "$tmpfile" "$url"; then
        mv -f "$tmpfile" "$filepath"
        echo "Download completed: $filepath"
    else
        echo "Download failed: $url"
        rm -f "$tmpfile"
        return 1
    fi
}

IFS=',' read -ra PRESETS <<< "$1"

echo "**** Checking presets and downloading corresponding files ****"

for preset in "${PRESETS[@]}"; do
    case "${preset}" in
        QWEN_EDIT)
            echo "Preset: QWEN_EDIT (Qwen Image Edit)"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_fp8_e4m3fn.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-Lightning-4steps-V1.0.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-Lightning-8steps-V1.0.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NMKD-Siax_200k.pth" "/workspace/ComfyUI/models/upscale_models"
            ;;
        QWEN_IMAGE)
            echo "Preset: QWEN_IMAGE (Qwen Image Generation)"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_fp8_e4m3fn.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-4steps-V1.0.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-8steps-V1.0.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NMKD-Siax_200k.pth" "/workspace/ComfyUI/models/upscale_models"
            ;;
        QWEN_IMAGE_BF16)
            echo "Preset: QWEN_IMAGE_BF16 (Qwen Image Full BF16 Generation)"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_bf16.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-4steps-V1.0.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-8steps-V1.0.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NMKD-Siax_200k.pth" "/workspace/ComfyUI/models/upscale_models"
            ;;
        QWEN_EDIT_BF16)
            echo "Preset: QWEN_EDIT_BF16 (Qwen Image Edit Full BF16)"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_bf16.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/lightx2v/Qwen-Image-Edit-Lightning/resolve/main/Qwen-Image-Edit-Lightning-4steps-V1.0.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/lightx2v/Qwen-Image-Edit-Lightning/resolve/main/Qwen-Image-Edit-Lightning-8steps-V1.0.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NMKD-Siax_200k.pth" "/workspace/ComfyUI/models/upscale_models"
            ;;
        *)
            echo "No matching QWEN preset for '${preset}', skipping."
            ;;
    esac
done
