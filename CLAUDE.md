# Project

<!-- Replace with one paragraph: what this project is, who it is for, and its stack. -->

## Workflow

Three systems, one owner per stage. Detailed rules: [docs/workflow.md](docs/workflow.md). Diagram, commands and limitations: [README.md](README.md).

- **Discovery and specification: Matt Pocock skills** (`mattpocock-skills:*`). An idea that fits one session starts with `grill-with-docs`; a large or greenfield one starts with `wayfinder`. Both end in `to-spec` (the spec issue) and `to-tickets` (the implementation issues). These entry skills, `triage` and `setup-matt-pocock-skills` are user-invoked: the human types `/mattpocock-skills:<name>`, so they are absent from the model's skill list by design.
- **Implementation: Superpowers** (`superpowers:*`), the only orchestrator. Every implementation issue enters through `superpowers:using-superpowers`, which picks the skills that follow.
- **Engineering principles: Pstack**, through the `engineering-principles` skill. Principles inform the other two stages and never run a stage.

## Rules

- An **implementation issue** is a `to-tickets` ticket (it has a Parent and Acceptance criteria) or a triaged bug brief labelled `ready-for-agent`. Spec issues and `wayfinder:*` decision tickets feed discovery; they are never implemented directly.
- Discovery sessions use Matt Pocock skills. Brainstorming belongs to implementation, for design gaps the spec and ADRs leave open.
- The spec issue, ADRs and `GLOSSARY.md` are settled context. When they settle a ticket's design, everything that matters is in the request: go straight to `superpowers:writing-plans`. Reopen a decision only on new evidence, as a question on the spec issue or a new ADR.
- A **trivial change** (one task, no design choice, no new interface) skips brainstorming and writing-plans; test-driven-development and verification-before-completion still apply.
- A plan's `**Spec:**` line names the ticket and its spec issue (read with `gh issue view <n>`), plus the design doc when brainstorming ran. `## Global Constraints` carries the binding ADR constraints and the principles chosen with `engineering-principles`. Each acceptance criterion maps to a task's test.
- TDD, debugging and code review run through Superpowers. Matt Pocock's `tdd`, `diagnosing-bugs` and `code-review` still show in the skill list but the model's calls to them are denied here, as are `implement`, `implement-spec` and `ask-matt`.
- Pstack's `/poteto-mode`, playbooks and agents are not installed; they run only when the user asks for them by name.
- Bugs: a report on the tracker goes through `mattpocock-skills:triage` first; a bug found during a session goes to `superpowers:systematic-debugging`. When `triage` posts, leave out its AI-disclaimer line (the one quoting its own authorship): the global no-attribution hook blocks it.

## Superpowers preferences

- Design docs go to `docs/superpowers/specs/`, plans to `docs/superpowers/plans/`. Both are gitignored working files; never `git add -f` them. A decision worth keeping goes to `docs/adr/` or a comment on the issue.
- Worktrees: always one per implementation issue, at `.worktrees/issue-<n>-<slug>` on branch `issue-<n>-<slug>`, without asking.
- Finishing: always push and open a PR whose body has `Closes #<n>`; never merge locally. The work ends at the open PR.

## Sources of truth

| Artifact | Lives in |
| --- | --- |
| Domain terms | `GLOSSARY.md` at the root, created by `domain-modeling` when the first term is resolved |
| Architectural decisions | `docs/adr/NNNN-<slug>.md` |
| What to build and why (spec, PRD) | the spec issue on the tracker |
| Implementation work | ticket issues: sub-issues of the spec, with blocked-by links |
| Execution plan | `docs/superpowers/plans/` (local) |
| Engineering principles | `.claude/skills/principle-*/` (vendored Pstack) |

## Agent skills

### Issue tracker

GitHub Issues on this repository's `origin`, through `gh`. See `docs/agents/issue-tracker.md`.

### Triage labels

Default five-label vocabulary (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: `GLOSSARY.md` at the repo root (created lazily by domain-modeling); ADRs in `docs/adr/`. See `docs/agents/domain.md`.
