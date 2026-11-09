#!/usr/bin/env bash
# Report which video-editor tools are installed. Read-only; changes nothing.
MODEL="${WHISPER_MODEL_DIR:-$HOME/whisper-models}/${WHISPER_MODEL:-ggml-large-v3-turbo-q5_0.bin}"
missing=0

row() { printf '%-14s %s\n' "$1" "$2"; }
check() { # name, version-command
  if command -v "$1" >/dev/null 2>&1; then row "$1" "OK  $(eval "$2" 2>/dev/null | head -1)"
  else row "$1" "MISSING"; missing=1; fi
}

check ffmpeg      "ffmpeg -version | cut -d' ' -f1-3"
check ffprobe     "ffprobe -version | cut -d' ' -f1-3"
check whisper-cli "echo whisper.cpp"
check yt-dlp      "yt-dlp --version"
check gallery-dl  "gallery-dl --version"
check hyperframes "hyperframes --version"
check node        "node --version"
check npx         "npx --version"

# ffmpeg-full (keg-only) is what burns subtitles/text; default brew ffmpeg lacks libass/freetype.
FULL=""
command -v brew >/dev/null 2>&1 && FULL="$(brew --prefix ffmpeg-full 2>/dev/null)/bin/ffmpeg"
if [[ -n "$FULL" && -x "$FULL" ]]; then row "ffmpeg-full" "OK  $FULL"
elif ffmpeg -hide_banner -filters 2>/dev/null | grep -q ' subtitles '; then row "ffmpeg-full" "not needed (ffmpeg has subtitles filter)"
else row "ffmpeg-full" "MISSING (needed only to burn in captions/text)"; missing=1; fi

if [[ -s "$MODEL" ]]; then row "whisper model" "OK  $MODEL"; else row "whisper model" "MISSING ($MODEL)"; missing=1; fi
row "remotion" "per-project (npx create-video@latest <name>)"

if (( missing )); then echo; echo "Run: bash $(cd "$(dirname "$0")" && pwd)/setup.sh"; exit 1; fi
