---
name: start
description: Initialize session — summarize project state, confirm active tools, set mode
model: ollama-cloud/kimi-k2.6:cloud
---

Do all of the following silently, then output a single summary block. No step-by-step narration.

## Steps

1. Confirm caveman mode active (per AGENTS.md)
2. Check if PRD.md exists in current directory — if yes, extract project goal in 1 line
3. Check if TASKS.md exists — if yes, count total tasks, count incomplete [ ] tasks, list next 3 incomplete tasks
4. Check if AGENTS.md exists locally (project-level) — if yes, note any project-specific overrides
5. Run `git status --short` — if dirty, note number of uncommitted files; if clean, note clean
6. Confirm Context7 MCP available
7. Confirm active model

## Output Format

Session ready.

**Project:** [goal from PRD.md] / No PRD found
**Tasks:** [X incomplete / Y total] — Next: [task 1], [task 2], [task 3] / No TASKS found
**Git:** [X uncommitted files] / Clean
**Model:** [current model]
**MCP:** Context7 ✓ / ✗
**Mode:** Caveman ✓