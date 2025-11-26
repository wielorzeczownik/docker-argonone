#!/usr/bin/env bash
set -euo pipefail

BASE=${1:-}

MAJOR_THRESHOLD=30
MINOR_THRESHOLD=10

if [[ -z "$BASE" ]]; then
  BASE=$(git rev-parse HEAD^ 2>/dev/null || true)
fi
if [[ -z "$BASE" ]]; then
  BASE="HEAD"
fi

diff_lines=$(git diff --numstat "$BASE" HEAD -- Dockerfile | awk '{a+=$1; d+=$2} END {print a+d}')
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

last_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "0.0.0")
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
} >> "$GITHUB_OUTPUT"
