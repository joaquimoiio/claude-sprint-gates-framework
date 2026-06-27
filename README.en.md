# Sprint-with-Gates Framework for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-framework-8A5CF6.svg)](https://claude.com/claude-code)

[🇧🇷 Português](README.md) · 🇬🇧 English

A **portable** framework for developing with AI (Claude Code) under a Sprint workflow with
**deterministic gates** — where "wait for approval" is not a polite request to the AI, but
a **physical lock**: a hook blocks writing code (exit code 2) until a human approves the
Sprint.

> The AI literally cannot "run ahead" even if it wants to.

> The framework document itself is in Portuguese (`FRAMEWORK-SPRINT-GATES.md`), but the
> concept is language-agnostic. This page summarizes it in English.

## Why it exists

LLMs tend to anticipate scope, implement extra things "while they're at it," and skip
steps. This framework fixes that with mechanics, not goodwill:

- **Each phase has an explicit command** (`/sprint-analisar`, `/sprint-planejar`, …) — no step-skipping.
- **GATE 2 is a hook**: without the `state/sprint-aprovada` flag, `Write`/`Edit` in source folders is blocked.
- **Quality is deterministic**: typecheck/lint run via hook after every edit, not from memory.
- **Isolated context per subagent**: the *architect* plans without implementing; the *devs* implement without redefining scope.
- **Durable, visible roadmap**: every Sprint becomes a file under `docs/sprints/` (one per Sprint) plus a `README.md` board with **done / in progress / to do** — maintained by the skills themselves (`/sprint-planejar` marks it 🔵, `/sprint-revisar` closes it ✅).

## The cycle

```
/sprint-analisar    → understand + surface gaps ................. GATE 1
/sprint-planejar    → document + stories + tasks + criteria ..... GATE 2  ← code LOCKED
/sprint-aprovar     → records the human "ok", creates the flag .. unlocks
/sprint-implementar → builds ONLY what was approved
/sprint-revisar     → audits against acceptance criteria ........ GATE 3
```

(The slash-command names are in Portuguese because that's how the skills ship; rename them
freely in your own copy.)

## How to use it in a new project

1. Copy **[`FRAMEWORK-SPRINT-GATES.md`](FRAMEWORK-SPRINT-GATES.md)** into your project root.
2. Open Claude Code there and paste the **bootstrap prompt** (section 2 of the document).
3. Answer the 5 questions (name, codebases, stack, quality command, models) — Claude Code
   scaffolds the entire `.claude/` adapted to your stack.

Everything in the document uses `<LIKE_THIS>` placeholders; nothing is tied to a specific
language or framework.

## What's here

| Path | What it is |
|------|------------|
| [`FRAMEWORK-SPRINT-GATES.md`](FRAMEWORK-SPRINT-GATES.md) | The portable kit: concept, **bootstrap prompt**, and all generic templates (in Portuguese). |
| [`exemplo/`](exemplo/) | A **complete, filled-in** instance for a fictional project ("Loja Analytics" — React + Node/TS). Shows how everything looks after bootstrap. |

See [`exemplo/README.md`](exemplo/README.md) for a walkthrough of what each file does and how
to test that the gate actually blocks.

## License

MIT — use, adapt, and share freely.
