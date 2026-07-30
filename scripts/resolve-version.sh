#!/usr/bin/env bash
set -euo pipefail

: "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"

emit() {
  {
    echo "released=$1"
    echo "version=${2#v}"
    echo "tag=$2"
  } >>"$GITHUB_OUTPUT"
}

last_tag=$(git describe --tags --abbrev=0 2>/dev/null || true)
next_tag=$(echo "${CLIFF_BUMPED_VERSION:-}" | tr -d '[:space:]')

if [[ -z "$next_tag" ]]; then
  next_tag="v0.1.0"
elif [[ "$next_tag" != v* ]]; then
  next_tag="v$next_tag"
fi

if [[ -n "$last_tag" && "$next_tag" == "$last_tag" ]]; then
  echo "No user-facing commits since ${last_tag}. Nothing to release."
  emit false "$last_tag"
  exit 0
fi

if [[ -n "$last_tag" && "$(printf '%s\n' "${last_tag#v}" "${next_tag#v}" | sort -V | tail -1)" != "${next_tag#v}" ]]; then
  echo "git-cliff returned $next_tag which is lower than current $last_tag. Nothing to release."
  emit false "$last_tag"
  exit 0
fi

emit true "$next_tag"
