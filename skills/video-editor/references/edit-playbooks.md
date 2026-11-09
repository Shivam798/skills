# Edit playbooks

Each playbook assumes the workspace `~/Videos/edits/<project>/{src,work,out}` and a transcript in `work/`.

## Talking-head → vertical reel (30–60 s)

1. Transcribe. Pick the strongest 30–60 s: a hook line that works with no
   context in the first 3 s, one idea, and a clear ending. Propose 2–3
   candidate segments with timestamps and let the user choose.
2. Trim to the segment and remove silences (tight: `d=0.3`), plus filler words
   ("um", "matlab", "basically") found via the word timings in the transcript JSON.
3. Reframe to 1080×1920 (center crop, or blurred-background fill if the subject moves).
4. Clean and normalise the audio (-14 LUFS).
5. Captions: HyperFrames word-highlight captions, 2–4 words on screen, kept
   inside the safe area (not the bottom 20% or the right 15%).
6. Optional: a punch-in zoom on key lines, a title card for the hook, ducked music.
7. Export, verify, and render a thumbnail from the hook frame.

## Podcast / long video → clips

1. Transcribe the full episode once. Find 5–8 self-contained moments (a
   strong claim, a story, a disagreement, a number), each 20–90 s.
2. List them with timestamps, the hook line and a suggested title. The user picks.
3. Run the reel playbook for each pick and batch the renders.

## Screen-recording tutorial cleanup

1. Remove dead air and mistakes (silencedetect + transcript: look for "let me redo that").
2. Speed up typing/loading segments 2–4x (setpts/atempo, or mute them).
3. Zoom into small UI moments (crop + scale on that range).
4. Add chapter title cards (HyperFrames), captions, and normalised audio.
5. Export at 1920×1080, source fps. Use `--video-frame-format png` in
   HyperFrames for crisp UI text.

## Recreate the style of a reference

1. Download (see downloading.md), then make the contact sheet, scene cuts and transcript.
2. Write a style brief: shot length, caption font/position/animation, colour
   look, transitions, music energy, hook structure.
3. Apply the style to the user's footage, not their content: match the rhythm
   and treatment, and never copy the reference's footage, music or script.

## Quick mechanical requests

| Ask | Do |
|---|---|
| "trim / cut X to Y" | single frame-accurate trim, re-encoded |
| "make it smaller / under 16 MB" | compute the bitrate: `target_bits / duration`, then a two-pass `-b:v` |
| "add subtitles file" | whisper → SRT, proof-read, deliver alongside (don't burn in unless asked) |
| "make a GIF" | two-pass palette GIF |
| "extract audio" | `-vn -c:a libmp3lame -q:a 2` |
