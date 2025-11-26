#!/usr/bin/env bash
set -euo pipefail

BASE_OVERRIDE=${1:-}

raw_tag=$(git describe --tags --abbrev=0 2>/dev/null || true)
base_for_diff="$BASE_OVERRIDE"
if [[ -z "$base_for_diff" ]]; then
  base_for_diff="$raw_tag"
fi
if [[ -z "$base_for_diff" || "$base_for_diff" == "0.0.0" ]]; then
  base_for_diff=$(git rev-parse HEAD^ 2>/dev/null || true)
fi
if [[ -z "$base_for_diff" ]]; then
  base_for_diff="HEAD"
fi

# Resolve to a concrete commit to avoid bad ranges
base_commit=$(git rev-list -n1 "$base_for_diff" 2>/dev/null || true)
if [[ -z "$base_commit" ]]; then
  base_commit="HEAD"
fi

changed="false"
if git diff --name-only "${base_commit}"..HEAD | grep -q '^Dockerfile$'; then
  changed="true"
fi

{
  echo "changed=${changed}"
  echo "base=${base_commit}"
} >> "${GITHUB_OUTPUT:-/dev/null}"
