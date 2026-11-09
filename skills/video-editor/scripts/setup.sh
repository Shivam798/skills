#!/usr/bin/env bash
# Install the video-editor toolchain. Idempotent: skips anything already present.
# macOS (Homebrew) is the primary target; Linux gets a best-effort apt/pipx path.
set -euo pipefail

MODEL_DIR="${WHISPER_MODEL_DIR:-$HOME/whisper-models}"
MODEL_NAME="${WHISPER_MODEL:-ggml-large-v3-turbo-q5_0.bin}"
MODEL_URL="https://huggingface.co/ggerganov/whisper.cpp/resolve/main/$MODEL_NAME"

say()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

if [[ "$(uname)" == "Darwin" ]]; then
  have brew || { echo "Homebrew is required: https://brew.sh"; exit 1; }
  for f in ffmpeg ffmpeg-full whisper-cpp yt-dlp gallery-dl node; do
    if brew list --formula "$f" >/dev/null 2>&1; then
      say "$f already installed"
    else
      say "installing $f"; brew install "$f"
    fi
  done
else
  say "Linux: installing via apt + pipx (whisper.cpp must be built from source)"
  sudo apt-get update -y
  sudo apt-get install -y ffmpeg nodejs npm pipx
  pipx install yt-dlp || pipx upgrade yt-dlp
  pipx install gallery-dl || pipx upgrade gallery-dl
  have whisper-cli || echo "!! build whisper.cpp: https://github.com/ggml-org/whisper.cpp (then put whisper-cli on PATH)"
fi

if have hyperframes; then
  say "hyperframes already installed ($(hyperframes --version 2>/dev/null | head -1))"
else
  say "installing hyperframes (npm -g)"; npm install -g hyperframes
fi

mkdir -p "$MODEL_DIR"
if [[ -s "$MODEL_DIR/$MODEL_NAME" ]]; then
  say "whisper model present: $MODEL_DIR/$MODEL_NAME"
else
  say "downloading whisper model $MODEL_NAME (~550 MB)"
  curl -L --fail --progress-bar -o "$MODEL_DIR/$MODEL_NAME.part" "$MODEL_URL"
  mv "$MODEL_DIR/$MODEL_NAME.part" "$MODEL_DIR/$MODEL_NAME"
fi

say "done. Remotion is per-project: npx create-video@latest <name>"
bash "$(dirname "$0")/doctor.sh"
