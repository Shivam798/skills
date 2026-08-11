<#
.SYNOPSIS
    Pulls skills from ~/.claude/skills/ back into this repo, ready to commit.

.DESCRIPTION
    Only needed when install.ps1 fell back to copy mode. Junction-installed
    skills already live in the repo, so they are detected and reported as
    already in sync rather than copied over themselves.

    By default only copies back skills the repo already tracks. Use -All to
    also adopt new skills created directly in ~/.claude/skills/.

.PARAMETER All
    Also copy in skills that exist in ~/.claude/skills/ but not yet in the repo.

.EXAMPLE
    .\backup.ps1
    .\backup.ps1 -All
#>
[CmdletBinding()]
param(
    [switch]$All
)

$ErrorActionPreference = 'Stop'

$repoSkills = Join-Path $PSScriptRoot 'skills'
$srcRoot    = Join-Path $HOME '.claude\skills'

if (-not (Test-Path $srcRoot)) {
    throw "No skills directory at $srcRoot - nothing to back up."
}

if (-not (Test-Path $repoSkills)) {
    New-Item -ItemType Directory -Path $repoSkills -Force | Out-Null
}

$copied = 0
$linked = 0

foreach ($skill in Get-ChildItem $srcRoot -Directory -Force) {
    $item = Get-Item $skill.FullName -Force
    $dest = Join-Path $repoSkills $skill.Name

    if ($item.LinkType -in @('Junction', 'SymbolicLink')) {
        Write-Host "  $($skill.Name.PadRight(20)) already in sync (junction)"
        $linked++
        continue
    }

    $tracked = Test-Path $dest
    if (-not $tracked -and -not $All) {
        Write-Warning "$($skill.Name): not tracked in this repo - re-run with -All to adopt it."
        continue
    }

    if ($tracked) {
        Remove-Item $dest -Recurse -Force -Confirm:$false
    }

    Copy-Item $skill.FullName -Destination $dest -Recurse -Force
    Write-Host "  $($skill.Name.PadRight(20)) copied -> $dest"
    $copied++
}

Write-Host ""
Write-Host "$copied copied, $linked already in sync."

Push-Location $PSScriptRoot
try {
    if (Get-Command git -ErrorAction SilentlyContinue) {
        $status = git status --porcelain
        if ($status) {
            Write-Host ""
            Write-Host "Pending changes:"
            $status | ForEach-Object { Write-Host "  $_" }
            Write-Host ""
            Write-Host 'Commit with:  git add -A; git commit -m "update skills"; git push'
        }
        else {
            Write-Host "Working tree clean - nothing to commit."
        }
    }
}
finally {
    Pop-Location
}
