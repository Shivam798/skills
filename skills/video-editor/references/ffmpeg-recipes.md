# ffmpeg recipes

Default encode flags used below. `ENC` = `-c:v libx264 -crf 18 -preset medium -pix_fmt yuv420p -c:a aac -b:a 192k`.

## Inspect

```bash
ffprobe -v error -show_entries format=duration,size:stream=index,codec_type,codec_name,width,height,r_frame_rate,sample_rate,channels -of compact in.mp4
ffmpeg -i in.mp4 -vf "scdet=threshold=10" -f null - 2>&1 | grep scdet   # scene cuts (useful for breaking down reference videos)
```

## Cutting & joining

```bash
# Several keep-ranges in one pass (frame-accurate, no intermediates)
ffmpeg -i in.mp4 -filter_complex "
 [0:v]trim=2:9,setpts=PTS-STARTPTS[v0];[0:a]atrim=2:9,asetpts=PTS-STARTPTS[a0];
 [0:v]trim=14:30,setpts=PTS-STARTPTS[v1];[0:a]atrim=14:30,asetpts=PTS-STARTPTS[a1];
 [v0][a0][v1][a1]concat=n=2:v=1:a=1[v][a]" -map "[v]" -map "[a]" $ENC out.mp4

# Join clips that differ in size/fps: normalise each first
ffmpeg -i a.mp4 -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,fps=30" -ar 48000 $ENC a_n.mp4
```

## Silence removal (jump cuts)

1. Detect: `ffmpeg -i in.mp4 -af silencedetect=noise=-30dB:d=0.4 -f null - 2>&1 | grep -E 'silence_(start|end)'`
2. Invert the silences into keep-ranges, padding each by ~0.08 s so words aren't clipped.
3. Feed the keep-ranges into the trim/concat `filter_complex` above (generate it with a short script; for >50 ranges, write the filter to a file and pass `-filter_complex_script f.txt`).

Tune `noise` (-35dB for quiet rooms, -25dB for noisy ones) and `d` (0.3 = tight/energetic, 0.7 = natural).
Cross-check against the transcript: don't cut pauses that are intentional emphasis.

## Framing

```bash
# 16:9 → 9:16, subject off-center: shift crop x (0 = left edge)
ffmpeg -i in.mp4 -vf "crop=ih*9/16:ih:x=400:y=0,scale=1080:1920" -c:a copy out.mp4
# 16:9 inside 9:16 with blurred background fill
ffmpeg -i in.mp4 -filter_complex "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,boxblur=20[bg];[0:v]scale=1080:-2[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2" -c:a copy out.mp4
# Slow punch-in zoom (Ken Burns), 5 s @30fps
ffmpeg -i in.mp4 -vf "zoompan=z='min(zoom+0.0008,1.15)':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1920x1080:fps=30" $ENC out.mp4
# Picture-in-picture (webcam bottom-right)
ffmpeg -i screen.mp4 -i cam.mp4 -filter_complex "[1:v]scale=480:-2[c];[0:v][c]overlay=W-w-40:H-h-40" -map 0:a? $ENC out.mp4
```

## Speed & time

```bash
ffmpeg -i in.mp4 -filter_complex "[0:v]setpts=PTS/1.25[v];[0:a]atempo=1.25[a]" -map "[v]" -map "[a]" $ENC out.mp4   # 1.25x
ffmpeg -i in.mp4 -vf "minterpolate=fps=60" out60.mp4                  # smooth slow-mo source
ffmpeg -i in.mp4 -vf "fade=t=in:st=0:d=0.5,fade=t=out:st=29.5:d=0.5" -af "afade=t=in:d=0.5,afade=t=out:st=29.5:d=0.5" $ENC out.mp4
```

## Audio

```bash
ffmpeg -i in.mp4 -af "highpass=f=80,afftdn=nf=-25,loudnorm=I=-14:TP=-1.5:LRA=11" -c:v copy out.mp4   # clean + normalise voice
# Background music ducked under voice (sidechain)
ffmpeg -i voice.mp4 -i music.mp3 -filter_complex "[1:a]volume=0.35[m];[m][0:a]sidechaincompress=threshold=0.03:ratio=8:attack=20:release=300[duck];[0:a][duck]amix=inputs=2:duration=first[a]" -map 0:v -map "[a]" -c:v copy -c:a aac out.mp4
ffmpeg -i in.mp4 -vn -c:a libmp3lame -q:a 2 audio.mp3                # extract audio
```

## Text & captions (needs ffmpeg-full)

```bash
FF="$(brew --prefix ffmpeg-full)/bin/ffmpeg"
$FF -i in.mp4 -vf "subtitles=subs.srt:force_style='FontSize=14,Bold=1,Outline=2,MarginV=60'" -c:a copy out.mp4
$FF -i in.mp4 -vf "drawtext=text='Part 1':fontsize=72:fontcolor=white:borderw=4:x=(w-tw)/2:y=h*0.12:enable='between(t,0,2.5)'" -c:a copy out.mp4
```

## Stills, thumbnails, GIF

```bash
ffmpeg -ss 12.5 -i in.mp4 -frames:v 1 -q:v 2 thumb.jpg
ffmpeg -i in.mp4 -vf "fps=1/5,scale=480:-1,tile=4x3" -frames:v 1 contact-sheet.png   # overview of the whole video
# Two-pass palette GIF
ffmpeg -i in.mp4 -vf "fps=15,scale=800:-1:flags=lanczos,palettegen=stats_mode=diff" pal.png
ffmpeg -i in.mp4 -i pal.png -lavfi "fps=15,scale=800:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=bayer:bayer_scale=3" out.gif
```

## Colour

```bash
ffmpeg -i in.mp4 -vf "eq=contrast=1.08:saturation=1.15:brightness=0.02" -c:a copy out.mp4
ffmpeg -i in.mp4 -vf "lut3d=look.cube" -c:a copy out.mp4          # apply a LUT
```
