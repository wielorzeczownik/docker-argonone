#!/usr/bin/env bash
set -euo pipefail

BASE=${1:-}

# Resolve base commit; fallback to previous commit when push event has no before SHA.
if [[ -z "$BASE" || "$BASE" == "0000000000000000000000000000000000000000" ]]; then
  BASE=$(git rev-parse HEAD^ 2>/dev/null || true)
fi
if [[ -z "$BASE" ]]; then
  BASE="HEAD"
fi

changed="false"
if git diff --name-only "$BASE" HEAD | grep -q '^Dockerfile$'; then
  changed="true"
fi

{
  echo "changed=${changed}"
  echo "base=${BASE}"
} >> "$GITHUB_OUTPUT"
