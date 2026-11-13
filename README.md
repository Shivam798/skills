# claude-skills

Portable backup of my personal Claude Code skills. This repo is the **source of
truth** — `~/.claude/skills/` is a working copy installed from here.

Created after losing an entire skill set to a laptop swap. Claude Code stores
skills as plain folders on local disk and does **not** sync them anywhere, so
without this repo they die with the machine.

## Skills

| Skill | Invoke | What it does |
|---|---|---|
| `dsa` | `/dsa <leetcode url \| number \| title>` | Solves a DSA problem as a ladder of approaches in interview-presentation order — brute force → refinements → optimal — with Java code, complexity in every heading, and a closing interview strategy. |
| `linkedin-post-writter` | *(auto — ask for a LinkedIn post)* | Writes authentic, Top-Voice-style LinkedIn posts: hook/body/close anatomy, four post formats (story, list, contrarian, observation), vulnerability guardrails, formatting rules and engagement strategy. |
| `video-generate-setup` | `/video-generate-setup` *(or auto — "install/check the video tools")* | Setup only, makes no videos. `scripts/doctor.sh` checks and `scripts/setup.sh` installs ffmpeg (+ffmpeg-full), whisper.cpp + model, yt-dlp, gallery-dl, Node/npx (Remotion per project), HyperFrames, uv, Chrome, the `~/VE` folders and the Kokoro voice env. Was `video-editor` (git tag `video-editor-final`). |
| `archify` | *(auto — ask for a diagram)* | Third-party skill from [tt-a1i/archify](https://github.com/tt-a1i/archify) (MIT). Turns a description or a repo into a validated, interactive standalone HTML diagram (architecture, workflow, sequence, data-flow, lifecycle). Outputs go to `~/Documents/archify`. Update with `npx skills add tt-a1i/archify -g -a claude-code -s archify -y`, then move it back here. |

## Set up on a new machine

macOS/Linux: symlink a skill into place, e.g. `ln -sfn "$PWD/skills/video-generate-setup" ~/.claude/skills/video-generate-setup`.
For `video-generate-setup`, then run `bash skills/video-generate-setup/scripts/setup.sh` to install the video tools.

Windows:

```powershell
git clone <your-repo-url> $HOME\Documents\claude-skills
cd $HOME\Documents\claude-skills
.\install.ps1
```

Restart Claude Code (or run `/context`) and the skills appear as slash commands.

`install.ps1` tries a **directory junction** first, so edits in either place stay
in sync automatically and no elevation is needed. If junctions are unavailable it
falls back to copying — in that case re-run `install.ps1` after every repo pull,
and `backup.ps1` before every commit.

## Day-to-day

```powershell
.\install.ps1          # repo  -> ~/.claude/skills   (after a pull, or on a new box)
.\backup.ps1           # ~/.claude/skills -> repo    (copy mode only; no-op on junctions)
git add -A; git commit -m "update dsa skill"; git push
```

## Add a new skill

```
skills/<skill-name>/SKILL.md          # required: YAML frontmatter (name, description) + body
skills/<skill-name>/references/*.md   # optional: examples, deep detail loaded on demand
```

The `description` field is what Claude matches against to decide the skill is
relevant — write it as a list of concrete trigger phrases, not a vague summary.
Then `.\install.ps1` and commit.

## Layout

```
claude-skills/
├── README.md
├── install.ps1
├── backup.ps1
├── .gitignore
└── skills/
    ├── dsa/
    │   ├── SKILL.md
    │   └── references/
    │       ├── example-238-product-except-self.md
    │       └── example-739-daily-temperatures.md
    ├── linkedin-post-writter/
    │   ├── SKILL.md
    │   └── references/
    │       ├── hooks.md
    │       └── examples.md
    └── archify/                 # third-party (tt-a1i/archify), vendored as-is
        ├── SKILL.md
        └── bin/ renderers/ schemas/ ...
```

## Also worth backing up

Not included here — different lifecycle, and may contain machine-specific or
sensitive values. Copy by hand if you want them:

- `~/.claude/CLAUDE.md` — global instructions
- `~/.claude/settings.json` — settings (review for secrets before committing)
- `~/.claude/commands/` — custom slash commands
- `~/.claude/agents/` — custom subagent definitions

Never commit `~/.claude/.credentials.json`.
