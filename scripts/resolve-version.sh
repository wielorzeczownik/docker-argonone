#!/usr/bin/env bash
set -euo pipefail

last_tag=$(git describe --tags --abbrev=0 2>/dev/null || true)
next_tag=$(echo "${CLIFF_BUMPED_VERSION:-}" | tr -d '[:space:]')

if [[ -z "$next_tag" ]]; then
  next_tag="v0.1.0"
elif [[ "$next_tag" != v* ]]; then
  next_tag="v$next_tag"
fi

if [[ -n "$last_tag" && "$next_tag" == "$last_tag" ]]; then
  echo "No user-facing commits since ${last_tag}. Nothing to release."
  echo "released=false" >>"$GITHUB_OUTPUT"
  echo "version=${last_tag#v}" >>"$GITHUB_OUTPUT"
  echo "tag=${last_tag}" >>"$GITHUB_OUTPUT"
  exit 0
fi

if [[ -n "$last_tag" && "$(printf '%s\n' "${last_tag#v}" "${next_tag#v}" | sort -V | tail -1)" != "${next_tag#v}" ]]; then
  echo "git-cliff returned $next_tag which is lower than current $last_tag. Nothing to release."
  echo "released=false" >>"$GITHUB_OUTPUT"
  echo "version=${last_tag#v}" >>"$GITHUB_OUTPUT"
  echo "tag=${last_tag}" >>"$GITHUB_OUTPUT"
  exit 0
fi

echo "released=true" >>"$GITHUB_OUTPUT"
echo "version=${next_tag#v}" >>"$GITHUB_OUTPUT"
echo "tag=${next_tag}" >>"$GITHUB_OUTPUT"
