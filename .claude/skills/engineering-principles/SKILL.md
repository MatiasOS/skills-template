---
name: engineering-principles
description: Engineering principles (Pstack). Picks the principles that bind the current work and writes them where plans, subagents and reviewers read them. Use when writing an implementation plan, debugging, writing tests, reviewing or verifying code, or when a discovery decision touches the domain model, architecture or product scope.
---

# Engineering principles

Pstack's principles are **standards**, not a workflow. Superpowers orchestrates implementation and Matt Pocock's skills own discovery; this skill decides which principles bind the work at hand and where they get written down.

The principles are vendored verbatim at `.claude/skills/principle-<name>/SKILL.md` (source and version: [PSTACK-PROVENANCE.md](PSTACK-PROVENANCE.md)). They are hidden from the Skill tool, so open them with the Read tool.

## Steps

1. **Name the moment.** The phase (a column of the index below) and the traits of the work: stateful logic, concurrency, external input, a new requirement in an old design, a migration, a measured number, a fix that keeps failing. Done when phase and traits fit in one line.
2. **Shortlist.** Pick the principles whose trigger matches a trait, usually two to five. Done when each shortlisted principle names the trait that triggered it.
3. **Read in full.** Read each shortlisted principle's SKILL.md before you apply or cite it, and drop any whose trigger, once read, does not hold. Cite only principles you read this session.
4. **Place them.** Write each kept principle into the artifact the next step consumes (see Placement). Done when every kept principle sits in that artifact.

## Placement

- **Implementation plan** (`superpowers:writing-plans`): one line per principle under `## Global Constraints`: `Principle <name>: <what it requires here> (.claude/skills/principle-<name>/SKILL.md)`. Every implementer and task reviewer receives Global Constraints verbatim, so this line is how a principle reaches subagents. A principle that binds a single task goes in that task's requirements instead.
- **Briefs you write yourself**: the principle's path plus its one-line application, never its pasted text.
- **Debugging** (`superpowers:systematic-debugging`): fix-root-causes from the first symptom; attack-the-premise once two fixes sharing a premise have failed.
- **Code review** (`superpowers:requesting-code-review`): pass the plan's principle lines as review requirements; a finding against a principle cites the offending line.
- **Verification** (`superpowers:verification-before-completion`): prove-it-works on every completion claim; explain-the-number when the claim is a measurement.
- **Discovery** (Matt Pocock skills): bring the principle's question into the grilling, such as model-the-domain while naming states or experience-first on a scope trade-off. A decision it drives becomes an ADR only when it passes the ADR gate.

## Precedence

Global and project CLAUDE.md first, then Superpowers' gates (design approval, plan review, the finishing step), then principles. Where they meet:

- **never-block-on-the-human** covers reversible steps inside an approved plan. Plans, design approval, questions the docs leave open, and irreversible actions go to the human.
- **exhaust-the-design-space** runs inside brainstorming's approaches step.
- **build-the-lever** and **encode-lessons-in-structure** favour an objective control over another line of prose: compiler settings and types, a lint or format rule, a unit, integration or contract test, an architecture test, a CI check. Propose it as a plan task.

Pstack's orchestration (`/poteto-mode`, its playbooks, `poteto-agent`) is not installed here; it enters the work only when the user asks for it by name. Links inside a principle to Pstack files that are not vendored are background reading, listed in PSTACK-PROVENANCE.md.

## Index

Phases: **D** discovery and domain modeling · **A** architecture and design · **P** planning · **C** coding · **T** testing · **B** debugging · **R** review · **V** verification.

| Principle | Applies when | Phases |
| --- | --- | --- |
| attack-the-premise | two or more fixes sharing one premise failed the same gate | B |
| boundary-discipline | wiring validation, error handling or framework adapters | A C R |
| build-the-lever | non-trivial edits, migrations, analyses or checks a tool could do or prove | P C |
| encode-lessons-in-structure | the same instruction or correction comes up a second time | P R |
| exhaust-the-design-space | a novel UI interaction or architectural decision with no precedent in the codebase | D A |
| experience-first | product, UX or feature-scope trade-offs | D A |
| explain-the-number | before trusting, reporting or acting on a measured number | T V |
| fix-root-causes | debugging any symptom | B C |
| foundational-thinking | choosing core types and data structures, scaffold-vs-feature order, shared state | D A P |
| guard-the-context-window | large outputs, long files, fan-out to subagents | P C |
| laziness-protocol | refactoring, judging diff size, tempted to add a layer | C R |
| make-operations-idempotent | commands, lifecycle steps or loops that can crash and retry | A C |
| migrate-callers-then-delete-legacy-apis | a new internal API while old callers still exist | P C |
| minimize-reader-load | code that is hard to trace | C R |
| model-the-domain | stateful logic, heavy branching, a shape assumption repeated across files | D A C |
| never-block-on-the-human | tempted to ask about a reversible step inside an approved plan | C |
| outcome-oriented-execution | planned rewrites or migrations with phase boundaries | P |
| prove-it-works | before declaring any task done | V |
| redesign-from-first-principles | a new requirement lands in an existing design | D A |
| separate-before-serializing-shared-state | concurrent actors, parallel subagents included, may write the same file, branch, key or state | A P C |
| sequence-verifiable-units | multi-step work; how commits and PRs stack | P |
| subtract-before-you-add | sequencing an addition, refactor or rewrite | P C |
| test-behavior-not-implementation | writing, changing or keeping a test | T R |
| type-system-discipline | designing types or signatures in a statically typed language | A C R |
