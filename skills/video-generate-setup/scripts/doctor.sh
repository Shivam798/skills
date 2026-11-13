#!/usr/bin/env bash
# Report which video tools are installed. Read-only; changes nothing. Exit 1 if anything is missing.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
VE="${VE:-$HOME/VE}"
MODEL="${WHISPER_MODEL_DIR:-$HOME/whisper-models}/${WHISPER_MODEL:-ggml-large-v3-turbo-q5_0.bin}"
missing=0
row() { printf '%-15s %s\n' "$1" "$2"; }
check() { if command -v "$1" >/dev/null 2>&1; then row "$1" "OK  $(eval "$2" 2>/dev/null | head -1)"; else row "$1" "MISSING"; missing=1; fi; }

check ffmpeg      "ffmpeg -version | cut -d' ' -f1-3"
check ffprobe     "ffprobe -version | cut -d' ' -f1-3"
check whisper-cli "brew list --versions whisper-cpp"
check yt-dlp      "yt-dlp --version"
check gallery-dl  "gallery-dl --version"
check node        "node --version"
check npx         "npx --version"
check uv          "uv --version"
check hyperframes "hyperframes --version"
FULL="$(brew --prefix ffmpeg-full 2>/dev/null)/bin/ffmpeg"
if [[ -x "$FULL" ]]; then row "ffmpeg-full" "OK  (burns subtitles/text)"; else row "ffmpeg-full" "MISSING"; missing=1; fi
if [ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then row "chrome" "OK  (frame capture)"; else row "chrome" "MISSING"; missing=1; fi
if [[ -s "$MODEL" ]]; then row "whisper model" "OK  $MODEL"; else row "whisper model" "MISSING ($MODEL)"; missing=1; fi
PY="$VE/Tools/tts-env/bin/python"
if [ -x "$PY" ] && "$PY" -I -c "import mlx_audio, numpy, scipy" 2>/dev/null; then row "voice env" "OK  $PY (mlx-audio $("$PY" -I -c 'import importlib.metadata as m; print(m.version("mlx-audio"))'))"
else row "voice env" "MISSING ($PY)"; missing=1; fi
if ls "$HOME/.cache/huggingface/hub/models--mlx-community--Kokoro-82M-bf16" >/dev/null 2>&1; then row "kokoro model" "OK"; else row "kokoro model" "MISSING"; missing=1; fi
for d in Projects Tools Voices "Exports/YouTube 16x9" "Exports/Instagram Reels 9x16"; do [ -d "$VE/$d" ] || { row "VE folders" "MISSING $VE/$d"; missing=1; }; done
row "remotion" "per project (npx create-video@latest <name>, or npm ci in a project)"
if (( missing )); then echo; echo "Run: bash $(cd "$(dirname "$0")" && pwd)/setup.sh"; exit 1; fi
