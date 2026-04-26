param(
    [int]$MaxIterations = 30,
    [int]$MaxTurns = 5,
    [string]$Model = "ollama-cloud/kimi-k2.6:cloud"
)

$ErrorActionPreference = "Stop"

$FALLBACK_MODELS = @(
    $Model,
    "ollama/glm-5:cloud",
    "ollama/gemma4:31b-cloud"
)

$CONTEXT_WARN_CHARS = 80000

# ── Helper: run opencode with quota-aware fallback ────────────────────────────
function Invoke-Opencode {
    param(
        [string]$Agent,
        [string]$Prompt
    )

    # Warn if prompt is large
    if ($Prompt.Length -gt $CONTEXT_WARN_CHARS) {
        Write-Host "   ⚠ Large context ($($Prompt.Length) chars). Consider splitting this task." -ForegroundColor Yellow
    }

    foreach ($m in $FALLBACK_MODELS) {
        $output = & opencode run --agent $Agent --model $m $Prompt 2>&1

        # Daily quota fully exhausted — no point retrying any model
        if ($output -match "limit: 0|PerDay|GenerateRequestsPerDay") {
            Write-Host ">> Daily quota fully exhausted on $m. Stopping loop." -ForegroundColor Red
            exit 0
        }

        # Rate limited — try next model
        if ($output -match "429|quota|rate.limit|RESOURCE_EXHAUSTED") {
            Write-Host "   ⚠ Quota hit on $m. Trying next model..." -ForegroundColor Yellow
            Start-Sleep -Seconds 5
            continue
        }

        # Success
        return $output
    }

    # All models exhausted
    Write-Host ">> All models quota-limited. Stopping loop gracefully." -ForegroundColor Red
    exit 0
}

# ── Step 1: Generate PRD if it doesn't exist ──────────────────────────────────
if (-not (Test-Path "PRD.md")) {
    Write-Host ">> No PRD.md found. Generating..." -ForegroundColor Cyan
    Invoke-Opencode -Agent "whiteboarding" -Prompt `
        "Read the codebase. Ask no questions — infer the project goal. Output a PRD.md with:
         - Project goal
         - Scope
         - Task list as checkboxes [ ]
         - Acceptance criteria per task
         - Out of scope"
    Write-Host ">> PRD.md generated. Review it, then re-run this script." -ForegroundColor Yellow
    exit 0
}

# ── Step 2: Generate TASKS.md from PRD if it doesn't exist ───────────────────
if (-not (Test-Path "TASKS.md")) {
    Write-Host ">> No TASKS.md found. Generating from PRD.md..." -ForegroundColor Cyan
    Invoke-Opencode -Agent "building" -Prompt `
        "Read PRD.md. Extract all tasks as a checklist into TASKS.md.
         Format: - [ ] task description
         Do not implement anything yet."
    Write-Host ">> TASKS.md generated." -ForegroundColor Green
}

# ── Step 3: Builder/Reviewer loop ─────────────────────────────────────────────
Write-Host ">> Starting build loop (max $MaxIterations iterations, max $MaxTurns turns per task)..." -ForegroundColor Cyan

$turnCount = 0

for ($i = 1; $i -le $MaxIterations; $i++) {
    Write-Host ""
    Write-Host "── Iteration $i ──────────────────────────────" -ForegroundColor DarkGray

    # Check if all tasks complete before building
    $tasks = Get-Content "TASKS.md" -ErrorAction SilentlyContinue
    $remaining = $tasks | Where-Object { $_ -match "^\- \[ \]" }
    if (-not $remaining) {
        Write-Host ">> All tasks complete." -ForegroundColor Green
        break
    }

    # Guard: max turns per task
    if ($turnCount -ge $MaxTurns) {
        Write-Host ">> Max turns ($MaxTurns) reached without PASS. Marking task for human review." -ForegroundColor Yellow
        # Tag the currently active task in TASKS.md
        (Get-Content "TASKS.md") -replace "^\- \[x\] (.+)$", "- [?] `$1 [NEEDS HUMAN REVIEW]" |
            Set-Content "TASKS.md"
        $turnCount = 0
        continue
    }

    # Builder
    Write-Host ">> Building... (turn $($turnCount + 1)/$MaxTurns)" -ForegroundColor Blue
    $build = Invoke-Opencode -Agent "building" -Prompt `
        "Read TASKS.md. Find the next incomplete task marked [ ].
         Implement it fully. Run tests if available. Commit with conventional commit message.
         Mark the task as complete [x] in TASKS.md.
         If all tasks are done, output: ALL COMPLETE
         Only work on ONE task per run."

    Write-Host $build

    if ($build -match "ALL COMPLETE") {
        Write-Host ">> Builder reports all complete." -ForegroundColor Green
        break
    }

    # Reviewer
    Write-Host ">> Reviewing..." -ForegroundColor Magenta
    $review = Invoke-Opencode -Agent "reviewing" -Prompt `
        "Read TASKS.md. Find the task just marked [x] most recently.
         Read PRD.md for its acceptance criteria.
         Review the last git commit against those criteria.
         Be concise: reference line numbers and function names only — no full code blocks.
         Output PASS or FAIL with max 3 specific reasons."

    Write-Host $review

    if ($review -match "FAIL") {
        $turnCount++
        Write-Host ""
        Write-Host ">> Review FAILED (turn $turnCount/$MaxTurns). Retrying task..." -ForegroundColor Red
        continue
    }

    # Passed — reset turn counter for next task
    $turnCount = 0
    Write-Host ">> PASSED. Moving to next task." -ForegroundColor Green
}

Write-Host ""
Write-Host ">> Loop complete." -ForegroundColor Cyan