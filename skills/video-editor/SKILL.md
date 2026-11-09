---
name: video-editor
description: AI video editing toolkit — set up and drive ffmpeg, whisper.cpp, yt-dlp, gallery-dl, HyperFrames and Remotion to cut, caption, reframe, grade, add motion graphics to, and export videos (reels, shorts, YouTube, LinkedIn). Use whenever the user wants to edit a video, trim/cut/merge clips, remove silences, add captions or subtitles, transcribe audio, make a reel/short/vertical version, add titles, overlays or motion graphics, download a reference video from YouTube or Instagram, convert to GIF, normalize audio, or says "install the video tools", "set up video editing", or invokes /video-editor.
---

# Video Editor

Edit videos from the terminal with free, local tools. Claude drives them; the
user describes the edit in plain words ("cut the ums, add captions, make it a
9:16 reel").

| Tool | What it does here |
|---|---|
| **ffmpeg / ffprobe** | Cutting, joining, scaling, cropping, speed, audio, encoding: the engine under everything |
| **ffmpeg-full** | Keg-only ffmpeg built with libass + freetype, used **only** to burn in subtitles and text (brew's default ffmpeg lacks these filters) |
| **whisper.cpp** (`whisper-cli`) | Local speech-to-text, giving transcripts, SRT/VTT captions and word timings (Hindi, English, Hinglish and more) |
| **yt-dlp** | Download reference videos from YouTube, Instagram reels, X, LinkedIn and others |
| **gallery-dl** | Instagram carousels, stories, whole profiles (what yt-dlp is weak at) |
| **HyperFrames** | HTML → MP4. Motion graphics, animated captions, title cards, overlays, written as web pages |
| **Remotion** | React → MP4. Programmatic videos and reusable templates (explainers, data-driven videos) |

## 0. Setup (first run on a machine)

Run the bundled scripts. They're idempotent, so they're safe to re-run.

```bash
bash ~/.claude/skills/video-editor/scripts/setup.sh   # installs everything (macOS/Homebrew; Linux best-effort)
bash ~/.claude/skills/video-editor/scripts/doctor.sh  # shows what's present, versions, and what's missing
```

`setup.sh` installs: ffmpeg, ffmpeg-full, whisper-cpp, yt-dlp, gallery-dl
(brew), hyperframes (npm -g), and downloads the Whisper model
`ggml-large-v3-turbo-q5_0.bin` (~550 MB) to `~/whisper-models/`. Remotion is
per-project, so it's created on demand (see §5).

Before any edit, run `doctor.sh` if you haven't this session. If something is
missing, tell the user and offer to run `setup.sh`; don't silently install.

## 1. The editing workflow

Always follow this order. It keeps the original safe and every step reversible.

1. **Workspace.** One folder per project, outside any code repo:
   `~/Videos/edits/<project-kebab>/` with `src/` (originals, never modified),
   `work/` (intermediates), `out/` (deliverables).
2. **Probe.** `ffprobe -v error -show_entries format=duration:stream=codec_type,codec_name,width,height,r_frame_rate,sample_rate -of compact <file>`.
   Note the resolution, fps, duration and whether there's audio. Never assume.
3. **Transcribe** anything with speech (§3). The transcript is the edit map:
   cuts, captions, chapters, and hook selection all come from it.
4. **Plan the edit** as a short numbered list with timestamps (keep / cut /
   overlay / caption style / output format). Show it to the user when the edit
   is creative or ambiguous; for a mechanical request ("trim 0:05–0:12"), just do it.
5. **Rough cut** with ffmpeg (§2): trims, silence removal, joins, reframing.
6. **Polish:** captions (§3), motion graphics/titles (§4–5), audio
   normalisation, music.
7. **Export** for the target platform (§6) to `out/`, then verify (§7).

## 2. ffmpeg essentials

See `references/ffmpeg-recipes.md` for the full cookbook. The ones you need most:

```bash
# Trim, frame-accurate (re-encode). Use -c copy only for rough keyframe cuts.
ffmpeg -ss 00:00:05 -to 00:00:42 -i in.mp4 -c:v libx264 -crf 18 -preset medium -c:a aac -b:a 192k work/clip.mp4

# Join clips with the same codec/size (list.txt lines: file 'a.mp4')
ffmpeg -f concat -safe 0 -i list.txt -c copy work/joined.mp4

# 16:9 → 9:16 center crop for reels/shorts
ffmpeg -i in.mp4 -vf "crop=ih*9/16:ih,scale=1080:1920" -c:a copy work/vertical.mp4

# Find silences (for jump cuts): prints silence_start / silence_end
ffmpeg -i in.mp4 -af silencedetect=noise=-30dB:d=0.5 -f null - 2>&1 | grep silence_

# Loudness normalise to -14 LUFS (YouTube/IG/LinkedIn target)
ffmpeg -i in.mp4 -af loudnorm=I=-14:TP=-1.5:LRA=11 -c:v copy out.mp4
```

Rules:
- Re-encode when cutting precisely; `-c copy` snaps to keyframes and can leave
  frozen frames at the start.
- Keep `-pix_fmt yuv420p` on final H.264 exports, or some players show black.
- Add `-movflags +faststart` to web deliverables.
- For many cuts, build one `filter_complex` with `trim`/`atrim` + `concat`
  rather than dozens of intermediate files (see the recipes file for the silence-removal script).

## 3. Transcripts & captions (whisper.cpp)

```bash
M=~/whisper-models/ggml-large-v3-turbo-q5_0.bin
ffmpeg -i in.mp4 -ar 16000 -ac 1 -c:a pcm_s16le work/audio.wav
whisper-cli -m $M -f work/audio.wav -l auto -osrt -ovtt -ojf -of work/transcript
#  -l hi / en / auto   -ml 42 -sow  → short caption lines split on words
#  -tr                 → translate to English
```

- `transcript.srt` gives timed captions (upload as a separate file, or burn in).
- `transcript.json` (`-ojf`) holds word-level timing, used for word-by-word
  animated captions and for precise cuts.
- For Hinglish, `-l hi` gives Devanagari; if the user wants Roman script, say
  so and transliterate the SRT text, keeping the timings.
- Always proof-read the SRT for names, brand words and technical terms before burning it in.

**Burning captions in.** Brew's default ffmpeg has no `subtitles`/`drawtext`
filter, so use ffmpeg-full:

```bash
FF="$(brew --prefix ffmpeg-full)/bin/ffmpeg"
$FF -i in.mp4 -vf "subtitles=work/transcript.srt:force_style='FontName=Inter,FontSize=14,Bold=1,PrimaryColour=&H00FFFFFF,OutlineColour=&H00000000,BorderStyle=1,Outline=2,Alignment=2,MarginV=60'" -c:a copy out/captioned.mp4
```

For styled, animated, word-highlight captions (the "reels" look), use HyperFrames (§4).

## 4. HyperFrames: motion graphics as HTML

Best for: animated captions, title cards, lower thirds, overlays on footage,
explainer scenes. A composition is an HTML page; HyperFrames renders it frame by frame.

```bash
cd ~/Videos/edits/<project>
hyperframes init graphics --video src/talk.mp4 --resolution portrait --language en --non-interactive
cd graphics
hyperframes preview                 # live studio in the browser
hyperframes check                   # lint + runtime validation + layout inspection
hyperframes render -o ../out/reel.mp4 --quality delivery
```

- `init --video` imports the clip and auto-transcribes it (word timings for captions).
- `hyperframes docs` shows inline docs; `hyperframes catalog` / `add` installs
  ready-made blocks (captions, lower thirds, transitions).
- Transparent overlays for CapCut/Premiere: `--format mov` (ProRes 4444 with alpha).
- `hyperframes snapshot` exports key frames as PNGs. Look at them before
  doing a full render.
- `init` may offer to install HyperFrames' own AI skills. Accept them; they
  teach the composition format in depth.

## 5. Remotion: programmatic video in React

Best for: reusable templates, data-driven videos, explainers built from code.

```bash
cd ~/Videos/edits && npx create-video@latest <project>    # new project (choose a template)
cd <project> && npm run dev                                # Remotion Studio preview
npx remotion render <CompositionId> out/video.mp4
npx remotion still <CompositionId> out/thumbnail.png --frame=30
```

- Each video is a `<Composition>` registered in `src/Root.tsx`; animate with
  `useCurrentFrame()` + `interpolate()` / `spring()`. Never use CSS transitions
  or `setTimeout`, because rendering is frame by frame.
- Put footage/audio in `public/` and load it with `staticFile()`; use `<OffthreadVideo>` for source video.
- Ship a `thumbnail.png` rendered as a still from a dedicated frame, not a grabbed mid-motion frame.

**HyperFrames or Remotion?** If the user knows React or wants a reusable
template, use Remotion. If it's one-off graphics on top of footage, captions,
or the user prefers HTML/CSS, use HyperFrames. Plain cuts and format changes
need neither, so just use ffmpeg.

## 6. Downloading references

See `references/downloading.md`.

```bash
yt-dlp -f "bv*+ba/b" --merge-output-format mp4 -o "src/%(title).80s.%(ext)s" "<url>"
yt-dlp --cookies-from-browser chrome "<instagram reel url>"            # IG usually needs login
gallery-dl --cookies-from-browser chrome "<instagram post/carousel url>"
```

Reference downloads are for study and private reference. Don't re-upload
someone else's content, and say so if the user's plan involves reposting.

## 7. Export presets & verification

| Target | Size | Notes |
|---|---|---|
| Reels / Shorts / TikTok | 1080×1920, 30 fps | ≤ 90 s for Reels; keep captions inside the middle ~70% (UI covers edges) |
| YouTube | 1920×1080 (or 4K), source fps | `-crf 18`, `-movflags +faststart` |
| LinkedIn / X | 1080×1080 or 1920×1080 | ≤ 10 min LinkedIn; burn captions in (most watch muted) |
| GIF | 800 px wide, 15 fps | Two-pass palette, see the recipes |

Standard final encode:
```bash
ffmpeg -i work/final.mov -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p -c:a aac -b:a 192k -movflags +faststart out/final.mp4
```

**Verify before saying done:** run `ffprobe` on the output (duration,
resolution, audio present). Grab 3–4 frames
(`ffmpeg -ss <t> -i out.mp4 -frames:v 1 work/check_<t>.png`) and look at them
for captions inside the safe area, a correct crop, and no black frames. Report
the output path, duration, size, and anything you couldn't verify.

## 8. Handing off to other editors

When the user finishes in CapCut / Premiere / Resolve, deliver pieces instead
of (or alongside) a final MP4: trimmed clips, the `.srt`, transparent `.mov`
overlays from HyperFrames, and the edit plan with timestamps.

## References

- `references/ffmpeg-recipes.md`: full cookbook (silence removal script, speed, zoom, picture-in-picture, music ducking, fades, GIF, thumbnails)
- `references/downloading.md`: yt-dlp / gallery-dl options, cookies, playlists, audio-only, troubleshooting
- `references/edit-playbooks.md`: step-by-step playbooks: talking-head reel, podcast clip, tutorial cleanup, reference-video breakdown
