# Pstack provenance

The 24 `.claude/skills/principle-*/SKILL.md` files come from Pstack by Lauren Tan, MIT licensed (license text, verbatim: [PSTACK-LICENSE](PSTACK-LICENSE)).

| | |
| --- | --- |
| Repository | https://github.com/cursor/plugins |
| Path | `harness/pstack/claude-code/skills/principle-*/SKILL.md`, the generated Claude Code copy of `pstack/` |
| Repository commit | `50b3a3234bf2e0293849a48784d72030948e44ee` (`main`, fetched 2026-11-19) |
| Last Pstack harness change | `e58dd043600587dbaf58ba315e7f2b38373eeb43` (2026-11-19) |
| Pstack version | 0.15.44 |
| State | All 24 verbatim, no edits. Each keeps `disable-model-invocation: true`, so the model reads them by path through the `engineering-principles` router and the user can still type `/principle-<name>`. |

## Left out on purpose

Everything else in Pstack, notably `/poteto-mode`, its playbooks (Feature, Multi-phase plan and the rest), the `poteto-agent` and `comment-sicko` agents, and `setup-pstack`. Superpowers is this repository's only implementation orchestrator, so Pstack contributes principles and nothing that runs work.

## Links that point outside this copy

Two principles link to Pstack files that are not vendored. They resolve upstream:

- `principle-explain-the-number` → `../benchmark-checklist/SKILL.md`: https://github.com/cursor/plugins/blob/50b3a3234bf2e0293849a48784d72030948e44ee/harness/pstack/claude-code/skills/benchmark-checklist/SKILL.md
- `principle-type-system-discipline` → `../../docs/harness/claude-code.md` (maps Cursor names to Claude Code): https://github.com/cursor/plugins/blob/50b3a3234bf2e0293849a48784d72030948e44ee/harness/pstack/claude-code/docs/harness/claude-code.md

## Updating

1. Sparse-clone `harness/pstack/claude-code/skills/principle-*` at the new commit into an empty scratch folder. Run nothing from it.
2. `diff -r <scratch>/harness/pstack/claude-code/skills .claude/skills -x engineering-principles` to see what changed, and check for added or removed principles.
3. Copy the files over, update the index in `engineering-principles/SKILL.md` if a principle was added, removed or retitled, and update the commits, version and date above.
4. Re-run the `diff -r`; it must come back empty.
