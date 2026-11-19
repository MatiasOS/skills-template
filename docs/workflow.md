# Workflow rules

The operating rules behind [CLAUDE.md](../CLAUDE.md). The diagram, the command for each stage and the known limitations live in [README.md](../README.md).

Matt Pocock's skills define **what** to build and **why**. Superpowers orchestrates **how** it gets built. Pstack's principles guide how well it is built.

## Vocabulary

These are workflow terms, not domain terms; the project's own domain language lives in `GLOSSARY.md`.

- **Spec issue**: the tracker issue `to-spec` publishes. It says what the software must do and why (problem, user stories, implementation and testing decisions, out of scope). It is the PRD. _Avoid_: spec document, requirements file.
- **Ticket**: a sub-issue of a spec issue, created by `to-tickets`, with What to build, Acceptance criteria and Blocked by. One ticket is one independently deliverable unit of work.
- **Bug brief**: an issue `triage` has labelled `ready-for-agent` with an Agent Brief comment.
- **Implementation issue**: a ticket or a bug brief. The only thing Superpowers picks up.
- **Map** and **decision ticket**: `wayfinder`'s artifacts. The map (`wayfinder:map`) tracks a large effort. Its decision tickets (`wayfinder:research|prototype|grilling|task`) each resolve one open question. They produce decisions, not code.
- **ADR**: `docs/adr/NNNN-<slug>.md`, a decision that is hard to reverse, surprising without context, and the result of a real trade-off. Discussions that fail any of the three stay out.
- **Design doc**: what `superpowers:brainstorming` writes to `docs/superpowers/specs/` when a ticket leaves design open. Local, gitignored, scoped to one ticket.
- **Plan**: what `superpowers:writing-plans` writes to `docs/superpowers/plans/`. Local, gitignored, scoped to one implementation issue.
- **Principle**: one of the vendored Pstack `principle-*` skills, selected through `engineering-principles`.

## Discovery: ready for implementation

Pick the entry by size. `grill-with-docs` sharpens an idea one session can hold, updating `GLOSSARY.md` and ADRs as terms and decisions resolve. `wayfinder` maps an idea one session cannot hold (a large feature, a greenfield project) as decision tickets and resolves them one at a time.

Work is **ready** when all of these hold:

- The spec issue exists and its open questions are answered. For a wayfinder effort, the map's Not yet specified section holds nothing the spec depends on.
- `to-tickets` has split the spec into tickets with acceptance criteria and blocked-by links. A small spec still gets its one ticket.
- The terms the tickets use are in `GLOSSARY.md`, and the decisions they rely on are ADRs.

When a discovery decision touches the domain model, the architecture or product scope, invoke `engineering-principles` and bring the matching principle's question into the grilling.

Each artifact has one home: the glossary holds definitions and nothing about implementation, ADRs hold decisions, the spec issue holds behaviour, tickets hold units of work. Point at an artifact; don't copy it.

## Implementation: one issue at a time

1. **Enter** through `superpowers:using-superpowers` with one implementation issue whose blockers are closed.
2. **Read the context**: the issue (`gh issue view <n>`), its spec issue, the ADRs that touch the area, and `GLOSSARY.md`. Answers already in them are settled; skip re-asking them.
3. **Design.** If the spec and ADRs settle the design, go to the plan. If a real design choice is still open, run `superpowers:brainstorming` for that gap and get the design doc approved. A trivial change (one task, no design choice, no new interface) goes straight to test-driven-development.
4. **Plan** with `superpowers:writing-plans`. Before writing it, invoke `engineering-principles`. The plan must have:
   - `**Spec:**` naming the issue, its spec issue, and the design doc if one exists.
   - `## Global Constraints` with each binding ADR constraint and each chosen principle (`Principle <name>: <what it requires here> (.claude/skills/principle-<name>/SKILL.md)`), one line each.
   - Tasks whose tests cover every acceptance criterion, at the seams named in the spec issue's Testing Decisions.
   - `## Review Focus` as Superpowers defines it.
5. **Execute** with `superpowers:subagent-driven-development` (the default) or `superpowers:executing-plans`, in a worktree at `.worktrees/issue-<n>-<slug>`, test-first.
6. **Review** with `superpowers:requesting-code-review`, and handle findings with `superpowers:receiving-code-review`. The reviewer checks the acceptance criteria and the plan's principle lines.
7. **Verify** with `superpowers:verification-before-completion`: fresh evidence that each acceptance criterion holds in the running software.
8. **Finish** with `superpowers:finishing-a-development-branch`: push, and open a PR with `Closes #<n>`. The work ends at the open PR.

When implementation exposes a gap or a contradiction in the spec, stop and raise it on the spec issue, or record a new ADR. Settle it in discovery terms before continuing.

## Bugs

- **Reported on the tracker**: `mattpocock-skills:triage` turns the report into a bug brief (`ready-for-agent`) or asks for more information. Leave out its AI-disclaimer line (the one quoting its own authorship); the global no-attribution hook rejects it.
- **Found during a session, or a bug brief picked up**: `superpowers:systematic-debugging`. Reproduce it, find the root cause, write the failing regression test, make the smallest fix that turns it green, then verify, review and finish as above. Invoke `engineering-principles` for fix-root-causes and, after repeated failed fixes, attack-the-premise.

## Subagent context

- General-purpose and custom subagents load `CLAUDE.md`, so the project rules reach them. The built-in Explore and Plan agents do not; brief them with paths.
- Superpowers' implementers read only their task brief plus the plan's Global Constraints. A principle, ADR constraint or glossary rule that is missing from the plan never reaches them.
- Hand over context as file paths and issue numbers, never pasted text.

## Blocked and turned-off skills

| Skill | Status here | Use instead | Why |
| --- | --- | --- | --- |
| `mattpocock-skills:implement`, `:implement-spec` | blocked | `superpowers:subagent-driven-development` | a second implementation orchestrator |
| `mattpocock-skills:tdd` | blocked | `superpowers:test-driven-development` | competing TDD loop |
| `mattpocock-skills:diagnosing-bugs` | blocked | `superpowers:systematic-debugging` | competing debugging loop |
| `mattpocock-skills:code-review` | blocked | `superpowers:requesting-code-review` | competing review loop |
| `mattpocock-skills:ask-matt` | blocked | this file | routes to `/implement` |
| user-level copies of Matt Pocock's skills (from skills.sh) | turned off | the `mattpocock-skills:*` plugin copies | the same skill listed twice |
| `to-prd`, `to-issues`, `decision-mapping`, `review`, `ubiquitous-language` | turned off | `to-spec`, `to-tickets`, `wayfinder`, `superpowers:requesting-code-review`, `domain-modeling` | legacy versions |

"Blocked" is a `permissions.deny` rule: the model's call is denied, though the skill may still appear in its list, and a human who types `/mattpocock-skills:<name>` still runs it. "Turned off" is a `skillOverrides` entry: the skill disappears for both. Both live in `.claude/settings.json`; remove the entry to bring a skill back.
