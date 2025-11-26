#!/usr/bin/env bash
set -euo pipefail

LAST_TAG=${1:-}

range=""
if [[ -n "$LAST_TAG" && "$LAST_TAG" != "0.0.0" ]]; then
  range="${LAST_TAG}..HEAD"
fi

notes=$(git log --pretty=format:"- %s (%h)" $range || true)
if [[ -z "$notes" ]]; then
  notes="- No commits found"
fi

{
  echo "notes<<'EOF'"
  echo "$notes"
  echo "EOF"
} >> "$GITHUB_OUTPUT"
