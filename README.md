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

## Set up on a new machine

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
    └── dsa/
        ├── SKILL.md
        └── references/
            ├── example-238-product-except-self.md
            └── example-739-daily-temperatures.md
```

## Also worth backing up

Not included here — different lifecycle, and may contain machine-specific or
sensitive values. Copy by hand if you want them:

- `~/.claude/CLAUDE.md` — global instructions
- `~/.claude/settings.json` — settings (review for secrets before committing)
- `~/.claude/commands/` — custom slash commands
- `~/.claude/agents/` — custom subagent definitions

Never commit `~/.claude/.credentials.json`.
