#!/usr/bin/env bash
# Create or update the labels the workflow's skills expect on this repo's GitHub tracker.
# Idempotent: `gh label create --force` updates a label that already exists.
#
#   scripts/bootstrap-github-labels.sh            # apply to the repo `gh` resolves from origin
#   scripts/bootstrap-github-labels.sh --dry-run  # print the commands only
#
# Sources: triage roles and categories from mattpocock-skills:triage and
# docs/agents/triage-labels.md; wayfinder labels from mattpocock-skills:wayfinder.
set -euo pipefail

dry_run=false
case "${1:-}" in
  --dry-run) dry_run=true ;;
  "") ;;
  *) echo "usage: $0 [--dry-run]" >&2; exit 2 ;;
esac

# name|color|description
labels=(
  "needs-triage|fbca04|Maintainer needs to evaluate this issue"
  "needs-info|d876e3|Waiting on reporter for more information"
  "ready-for-agent|0e8a16|Fully specified, ready for an agent"
  "ready-for-human|1d76db|Requires human implementation"
  "wontfix|ffffff|Will not be actioned"
  "bug|d73a4a|Something is broken"
  "enhancement|a2eeef|New feature or improvement"
  "wayfinder:map|5319e7|Wayfinder map of a large effort"
  "wayfinder:research|c5def5|Wayfinder decision ticket: research"
  "wayfinder:prototype|c5def5|Wayfinder decision ticket: prototype"
  "wayfinder:grilling|c5def5|Wayfinder decision ticket: grilling"
  "wayfinder:task|c5def5|Wayfinder decision ticket: task"
)

if ! $dry_run; then
  repo=$(gh repo view --json nameWithOwner --jq .nameWithOwner)
  echo "Applying ${#labels[@]} labels to ${repo}"
fi

for entry in "${labels[@]}"; do
  IFS='|' read -r name color description <<<"$entry"
  if $dry_run; then
    printf 'gh label create %q --color %q --description %q --force\n' "$name" "$color" "$description"
  else
    gh label create "$name" --color "$color" --description "$description" --force
  fi
done
