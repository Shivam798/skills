---
name: video-generate-setup
description: Install and check the local toolchain for making videos on this Mac: ffmpeg (+ ffmpeg-full for burned-in text), whisper.cpp + model, yt-dlp, gallery-dl, Node/npx (Remotion runs per project), HyperFrames, uv, Google Chrome, the ~/VE folder layout, and the shared voice env ~/VE/Tools/tts-env (mlx-audio Kokoro). Setup only, it does not make or edit videos. Use when the user says "install the video tools", "set up video generation", "check video setup", "what's installed for video", on a new machine, or when a video skill reports something missing, or invokes /video-generate-setup.
---

# Video Generate Setup

This skill only **installs and checks** tools for the VE workspace (`~/VE`). It does not make, edit or render videos.

## Check (read-only)
```bash
bash ~/.claude/skills/video-generate-setup/scripts/doctor.sh
```
It prints OK or MISSING for every tool and exits 1 if anything is missing. Run it first and report the table to the user.

## Install (idempotent)
```bash
bash ~/.claude/skills/video-generate-setup/scripts/setup.sh
```
Ask before running it if anything would be installed (it uses brew, npm -g and downloads). It prints **All set** when done.

| what | how it's installed | used for |
|---|---|---|
| ffmpeg, ffprobe | brew | encode, cut, mix, loudness (-14 LUFS) |
| ffmpeg-full | brew (keg-only) | burning subtitles or text into video |
| whisper.cpp + `~/whisper-models/ggml-large-v3-turbo-q5_0.bin` | brew + download (~550 MB) | word timings, transcripts, captions, voice QA |
| yt-dlp, gallery-dl | brew | downloading reference videos and posts (study only) |
| Node + npx | brew | Remotion (per project, `npx create-video@latest`) |
| HyperFrames | npm -g | HTML → video overlays and captions |
| uv | brew | Python envs |
| Google Chrome | manual (google.com/chrome) | headless frame capture |
| `~/VE/` folders | mkdir | `Projects/ Raw Footage/ References/ Tools/ Voices/ Exports/{YouTube 16x9, Instagram Reels 9x16}` |
| `~/VE/Tools/tts-env` + Kokoro-82M | uv venv + mlx-audio, numpy, scipy, misaki | the default voices (Kokoro presets) |

## After setup
- Optional, only when the user asks: custom voice models (Qwen3 VoiceDesign, Chatterbox) load into the same env on first use,
  and Veena (Indian voices) lives in `~/VE/Tools/veena-env`. See `~/VE/Voices/README.md`.

## Rules
- Never delete or reinstall something that already works. Report MISSING items and offer the fix.
- Don't install or download anything that wasn't asked for. Ask before running setup.sh.
