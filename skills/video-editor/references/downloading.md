# Downloading reference videos

For study and private reference only. Don't re-upload other creators' work.

## yt-dlp (YouTube, Instagram reels, X, LinkedIn, Vimeo, 1000+ sites)

```bash
yt-dlp -F "<url>"                                                   # list available formats
yt-dlp -f "bv*[height<=1080]+ba/b" --merge-output-format mp4 -o "src/%(title).80s.%(ext)s" "<url>"
yt-dlp -x --audio-format mp3 "<url>"                                # audio only
yt-dlp --download-sections "*00:01:30-00:02:10" "<url>"             # just a section
yt-dlp --write-subs --write-auto-subs --sub-langs "en.*" --skip-download "<url>"   # captions only
yt-dlp -o "src/%(playlist_index)03d-%(title).60s.%(ext)s" "<playlist url>"
```

## Instagram

Instagram rate-limits and often requires login. Pass cookies from a browser
where you're logged in (the Chrome profile name matters):

```bash
yt-dlp --cookies-from-browser chrome "https://www.instagram.com/reel/XXXX/"
yt-dlp --cookies-from-browser "chrome:Profile 1" "<url>"            # a non-default Chrome profile
gallery-dl --cookies-from-browser chrome "https://www.instagram.com/p/XXXX/"        # carousel (images + videos)
gallery-dl --cookies-from-browser chrome "https://www.instagram.com/stories/<user>/"
gallery-dl --cookies-from-browser chrome -D src/<user> "https://www.instagram.com/<user>/reels/"
```

Use yt-dlp for single reels/videos and gallery-dl for carousels, stories and bulk.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `HTTP 403`, "Sign in to confirm", empty IG result | Add `--cookies-from-browser`; update with `brew upgrade yt-dlp` (sites change often) |
| Cookies can't be read | Quit Chrome fully, or export a `cookies.txt` and pass `--cookies cookies.txt` |
| Rate limited | Add `--sleep-requests 2`; avoid bulk pulls from one account |
| WebM/VP9 output that editors dislike | `-S "vcodec:h264,res,acodec:m4a"` to prefer H.264 + AAC |

## Breaking down a reference video

After downloading: make a contact sheet (`fps=1/2,tile=6x5`), detect scene cuts
(`scdet`), and transcribe it. Then summarise the hook (first 3 s), the cut rhythm
(average shot length), caption style, the music/energy curve and the CTA, and
map those onto the user's own footage. `hyperframes measure <video>` also
reports cuts, motion and the overall look.
