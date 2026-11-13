#!/usr/bin/env bash
# Install everything the video tools need on this Mac. Idempotent: skips anything already present. Prints "All set".
#   brew: ffmpeg, ffmpeg-full, whisper-cpp, yt-dlp, gallery-dl, node, uv · npm -g: hyperframes
#   whisper model ~/whisper-models/ggml-large-v3-turbo-q5_0.bin · VE folders · voice env ~/VE/Tools/tts-env (mlx-audio
#   Kokoro + numpy + scipy + misaki) and the Kokoro model · Remotion is per project (npx), nothing global.
set -euo pipefail
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
VE="${VE:-$HOME/VE}"
MODEL_DIR="${WHISPER_MODEL_DIR:-$HOME/whisper-models}"
MODEL_NAME="${WHISPER_MODEL:-ggml-large-v3-turbo-q5_0.bin}"
MODEL_URL="https://huggingface.co/ggerganov/whisper.cpp/resolve/main/$MODEL_NAME"
ENV="$VE/Tools/tts-env"
say()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

[[ "$(uname)" == "Darwin" ]] || { echo "macOS only (Apple Silicon: the voice env uses MLX)"; exit 1; }
have brew || { echo "Homebrew is required: https://brew.sh"; exit 1; }
for f in ffmpeg ffmpeg-full whisper-cpp yt-dlp gallery-dl node uv; do
  if brew list --formula "$f" >/dev/null 2>&1; then say "$f already installed"; else say "installing $f"; brew install "$f"; fi
done
[ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ] || echo "!! Google Chrome is needed for frame capture: install it from google.com/chrome"

if have hyperframes; then say "hyperframes already installed"; else say "installing hyperframes (npm -g)"; npm install -g hyperframes; fi

mkdir -p "$MODEL_DIR"
if [[ -s "$MODEL_DIR/$MODEL_NAME" ]]; then say "whisper model present"; else
  say "downloading whisper model $MODEL_NAME (~550 MB)"
  curl -L --fail --progress-bar -o "$MODEL_DIR/$MODEL_NAME.part" "$MODEL_URL"; mv "$MODEL_DIR/$MODEL_NAME.part" "$MODEL_DIR/$MODEL_NAME"
fi

mkdir -p "$VE/Projects" "$VE/Raw Footage" "$VE/References" "$VE/Tools" "$VE/Voices/cast" "$VE/Voices/auditions" \
         "$VE/Exports/YouTube 16x9" "$VE/Exports/Instagram Reels 9x16"
say "VE folders ready in $VE"

if [ ! -x "$ENV/bin/python" ]; then say "creating voice env $ENV (Python 3.12)"; uv venv --python 3.12 "$ENV"; fi
if "$ENV/bin/python" -I -c "import mlx_audio, numpy, scipy, misaki" 2>/dev/null; then say "voice env ok"; else
  say "installing mlx-audio + numpy + scipy + misaki into $ENV"
  uv pip install --python "$ENV/bin/python" mlx-audio numpy scipy "misaki[en]"
fi
say "fetching the Kokoro voice model (once, ~350 MB)"
"$ENV/bin/python" -I -c "from mlx_audio.tts.utils import load_model; load_model('mlx-community/Kokoro-82M-bf16')" >/dev/null 2>&1 \
  && say "Kokoro ready" || echo "!! Kokoro model failed to load: run again, or check the internet connection"

bash "$(dirname "$0")/doctor.sh" && echo "All set"
