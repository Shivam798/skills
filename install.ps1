<#
.SYNOPSIS
    Installs the skills in this repo into ~/.claude/skills/.

.DESCRIPTION
    For each folder under .\skills\, creates a directory junction at
    ~/.claude/skills/<name> pointing back into this repo, so edits made in
    either location stay in sync and nothing needs re-running after a pull.

    Junctions need no administrator rights. If one cannot be created, the
    script falls back to a plain recursive copy and says so.

.PARAMETER Copy
    Force copy mode instead of junctions.

.PARAMETER Force
    Replace an existing target even if it is a real directory with content.
    Without this, existing real directories are skipped and reported.

.EXAMPLE
    .\install.ps1
    .\install.ps1 -Copy -Force
#>
[CmdletBinding()]
param(
    [switch]$Copy,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$repoSkills = Join-Path $PSScriptRoot 'skills'
$destRoot   = Join-Path $HOME '.claude\skills'

if (-not (Test-Path $repoSkills)) {
    throw "No skills\ directory found in $PSScriptRoot"
}

if (-not (Test-Path $destRoot)) {
    New-Item -ItemType Directory -Path $destRoot -Force | Out-Null
    Write-Host "Created $destRoot"
}

$installed = 0
$skipped   = 0

foreach ($skill in Get-ChildItem $repoSkills -Directory) {
    $src  = $skill.FullName
    $dest = Join-Path $destRoot $skill.Name

    if (-not (Test-Path (Join-Path $src 'SKILL.md'))) {
        Write-Warning "$($skill.Name): no SKILL.md, skipping"
        $skipped++
        continue
    }

    if (Test-Path $dest) {
        $existing = Get-Item $dest -Force
        $isLink   = $existing.LinkType -in @('Junction', 'SymbolicLink')

        if ($isLink) {
            # Ours to replace freely - a link holds no unique data.
            Remove-Item $dest -Force -Recurse -Confirm:$false
        }
        elseif ($Force) {
            Write-Host "$($skill.Name): replacing existing directory (-Force)"
            Remove-Item $dest -Force -Recurse -Confirm:$false
        }
        else {
            Write-Warning "$($skill.Name): a real directory already exists at $dest - skipping. Inspect it, then re-run with -Force to overwrite."
            $skipped++
            continue
        }
    }

    $linked = $false

    if (-not $Copy) {
        try {
            New-Item -ItemType Junction -Path $dest -Target $src -ErrorAction Stop | Out-Null
            $linked = $true
        }
        catch {
            Write-Warning "$($skill.Name): junction failed ($($_.Exception.Message.Trim())) - copying instead"
        }
    }

    if (-not $linked) {
        Copy-Item $src -Destination $dest -Recurse -Force
    }

    $mode = if ($linked) { 'junction' } else { 'copy' }
    Write-Host "  $($skill.Name.PadRight(20)) $mode -> $dest"
    $installed++
}

Write-Host ""
Write-Host "Installed $installed skill(s)$(if ($skipped) { ", skipped $skipped" })."
Write-Host "Restart Claude Code to pick them up."
