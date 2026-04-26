# OpenCode Configuration

My personal [OpenCode](https://opencode.ai/docs) configuration.

Before OpenCode existed, I maintained a personal "second brain". A collection of notes on programming patterns, product management frameworks, and psychology principles. I found it valuable to transform these notes into skills that the AI can execute, making my accumulated knowledge actionable during coding sessions.

Feel free to:
- Browse and adapt skills for your own config
- Use agents as templates for your workflows
- Share tips and tricks you've found useful

## Structure

```
.
├── AGENTS.md          # Personal preferences & coding guidelines
├── opencode.json      # Main config (plugins, MCP servers, providers)
├── agents/            # Custom agents for specialized tasks
├── skills/            # Executable knowledge notes
├── commands/          # Custom slash commands
└── tools/             # Helper scripts (commit message utilities)
```

## Custom Agents

| Agent | Purpose |
|-------|---------|
| [`orchestrator`](./agents/orchestrator.md) | Route tasks to the right specialist agent |
| [`building`](./agents/building.md) | Implement strictly against an agreed spec |
| [`reviewing`](./agents/reviewing.md) | Verify implementation against the agreed spec |
| [`code-reviewer`](./agents/code-reviewer.md) | Comprehensive code review |
| [`code-simplifier`](./agents/code-simplifier.md) | Refactor for clarity and maintainability |
| [`compound-engineering`](./agents/compound-engineering.md) | Full brainstorm → plan → work → review → compound cycle |
| [`deep-thinker`](./agents/deep-thinker.md) | Structured thinking for complex problems |
| [`effort-estimator`](./agents/effort-estimator.md) | Estimate development effort |
| [`prompt-simplifier`](./agents/prompt-simplifier.md) | Review prompts for logical complexity and ambiguity |
| [`refactoring`](./agents/refactoring.md) | Plan and implement code refactoring |
| [`requirements-analyzer`](./agents/requirements-analyzer.md) | Analyze feature requirements |
| [`skill-creator`](./agents/skill-creator.md) | Create new skills with proper structure |
| [`talk`](./agents/talk.md) | Conversational interactions |
| [`web-researcher`](./agents/web-researcher.md) | Internet research specialist |
| [`whiteboarding`](./agents/whiteboarding.md) | Clarify requirements before implementation |
| [`approved`](./agents/approved.md) | Track what has been reviewed and approved |

## Skills Library

Skills are **executable knowledge notes** — my personal "second brain" converted into actionable guidance for the AI agent.

| Category | Skills |
|----------|--------|
| TypeScript | [best practices](./skills/typescript-best-practices/SKILL.md), [advanced types](./skills/typescript-advanced-types/SKILL.md), [`satisfies` operator](./skills/typescript-satisfies-operator/SKILL.md), [interface vs type](./skills/typescript-interface-vs-type/SKILL.md) |
| React | [`useState`](./skills/react-use-state/SKILL.md), [`useCallback`](./skills/react-use-callback/SKILL.md), [`useEffect` avoid](./skills/react-useeffect-avoid/SKILL.md), [`key` prop](./skills/react-key-prop/SKILL.md), [`"use client"` boundaries](./skills/react-use-client-boundary/SKILL.md), [Next.js image art direction](./skills/nextjs-image-art-direction/SKILL.md) |
| CSS / Tailwind | [container queries](./skills/css-container-queries/SKILL.md), [Tailwind v4 configuration](./skills/tailwind-v4-configuration/SKILL.md), [Tailwind v4 best practices](./skills/code-architecture-tailwind-v4-best-practices/SKILL.md) |
| Architecture | [naming conventions](./skills/naming-cheatsheet/SKILL.md), [project structure](./skills/project-structure/SKILL.md), [wrong abstraction patterns](./skills/code-architecture-wrong-abstraction/SKILL.md), [conventional commits](./skills/conventional-commit/SKILL.md) |
| Product Frameworks | [Jobs-to-be-Done](./skills/jobs-to-be-done/SKILL.md), [Business Model Canvas](./skills/business-model-canvas/SKILL.md), [Hooked Model](./skills/hooked-model/SKILL.md), [Fogg Behavior Model](./skills/fogg-behavior-model/SKILL.md), [PEST analysis](./skills/pest-analysis/SKILL.md), [product decisions](./skills/making-product-decisions/SKILL.md), [PRD generation](./skills/prd/SKILL.md), [Ralph PRD format](./skills/ralph/SKILL.md) |
| UX Psychology | [cognitive load](./skills/cognitive-load/SKILL.md), [cognitive biases](./skills/cognitive-biases/SKILL.md), [cognitive fluency](./skills/cognitive-fluency-psychology/SKILL.md), [Hick's law](./skills/hicks-law/SKILL.md), [progressive disclosure](./skills/progressive-disclosure/SKILL.md), [trust signals](./skills/trust-psychology/SKILL.md), [halo effect](./skills/halo-effect-psychology/SKILL.md), [visual cues & CTAs](./skills/visual-cues-cta-psychology/SKILL.md) |
| Behavioral Design | [loss aversion](./skills/loss-aversion-psychology/SKILL.md), [status quo bias](./skills/status-quo-bias/SKILL.md), [social proof](./skills/social-proof-psychology/SKILL.md), [curiosity gap](./skills/curiosity-gap/SKILL.md), [self-initiated triggers](./skills/self-initiated-triggers/SKILL.md) |
| Decision Making | [hypothesis trees](./skills/hypothesis-tree/SKILL.md), [five whys](./skills/five-whys/SKILL.md), [graph thinking](./skills/graph-thinking/SKILL.md), [game theory (tit-for-tat)](./skills/game-theory-tit-for-tat/SKILL.md) |
| Agile | [Kanban](./skills/kanban/SKILL.md), [theme-epic-story hierarchy](./skills/theme-epic-story/SKILL.md), [user stories](./skills/user-story-fundamentals/SKILL.md), [Kaizen](./skills/kaizen/SKILL.md) |
| Product Management | [what not to do as PM](./skills/what-not-to-do-as-product-manager/SKILL.md), [value realization](./skills/value-realization/SKILL.md) |
| Automation & Testing | [agent-browser](./skills/agent-browser/SKILL.md), [dogfood / QA](./skills/dogfood/SKILL.md), [Electron automation](./skills/electron/SKILL.md), [Slack automation](./skills/slack/SKILL.md), [Vercel sandbox](./skills/vercel-sandbox/SKILL.md) |
| Personal Organization | [PARA method](./skills/para-method/SKILL.md), [deliberate practice](./skills/deliberate-practice/SKILL.md) |

## MCP Servers

- **Context7** — Real-time library/API documentation (remote)
- **Exa** — Web search and code examples (remote)
- **Figma MCP Desktop** — Design file integration, local (`http://127.0.0.1:3845/mcp`)
- **Playwright** — Browser automation (local)
- **GitHub** — Repository operations (local)

## Plugins

- `@franlol/opencode-md-table-formatter@0.0.3` — Markdown table formatting
- `@mohak34/opencode-notifier@latest` — Desktop notifications
- `opencode-snip@latest` — Code snippet utilities
- `@tarquinen/opencode-dcp@latest` — DCP context management
- `opencode-froggy` — Froggy integration
- `envsitter-guard@latest` — Environment variable security
- `opencode-antigravity-multi-auth@latest` — Multi-provider auth
- `@spoons-and-mirrors/pocket-universe@latest` — Pocket Universe integration
- `opencode-mystatus` — AI quota status tracking
- `opencode-gemini-auth@latest` — Gemini auth support
- `opencode-claude-auth@latest` — Claude auth support
- `opencode-openai-codex-auth` — OpenAI Codex auth support

## Resources

- [OpenCode Documentation](https://opencode.ai/docs)
- [Skills Guide](https://opencode.ai/docs/skills)
- [Agents Guide](https://opencode.ai/docs/agents)

## License

[MIT](./LICENSE)
