#!/usr/bin/env bash
set -euo pipefail

MAJOR_THRESHOLD=30
MINOR_THRESHOLD=10

BASE_OVERRIDE=${1:-}

raw_tag=$(git describe --tags --abbrev=0 2>/dev/null || true)
last_tag=$(printf '%s' "${raw_tag:-0.0.0}" | sed 's/^[vV]//; s/^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/')

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

base_commit=$(git rev-list -n1 "$base_for_diff" 2>/dev/null || true)
if [[ -z "$base_commit" ]]; then
  base_commit="HEAD"
fi

diff_lines=$(git diff --numstat "${base_commit}"..HEAD -- Dockerfile | awk '{a+=$1; d+=$2} END {print a+d}')
if [[ -z "$diff_lines" ]]; then
  diff_lines=0
fi

if [[ "$diff_lines" -ge "$MAJOR_THRESHOLD" ]]; then
  bump="major"
elif [[ "$diff_lines" -ge "$MINOR_THRESHOLD" ]]; then
  bump="minor"
else
  bump="patch"
fi

IFS=. read -r major minor patch <<<"$last_tag"
major=${major:-0}
minor=${minor:-0}
patch=${patch:-0}

case "$bump" in
  major) major=$((major + 1)); minor=0; patch=0 ;;
  minor) minor=$((minor + 1)); patch=0 ;;
  *) patch=$((patch + 1)) ;;
esac

next_version="${major}.${minor}.${patch}"

{
  echo "bump=${bump}"
  echo "diff_lines=${diff_lines}"
  echo "last_tag=${last_tag}"
  echo "version=${next_version}"
} >> "${GITHUB_OUTPUT:-/dev/null}"
