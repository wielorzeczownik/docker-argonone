#!/usr/bin/env bash
set -euo pipefail

LAST_TAG=${1:-}
NEW_VERSION=${2:-}

if [[ -z "$NEW_VERSION" ]]; then
  echo "Usage: $0 <last-tag> <new-version>" >&2
  exit 1
fi

LAST_TAG="v${LAST_TAG}"
TAG_NAME="v${NEW_VERSION}"
RELEASE_DATE=$(date -u +%Y-%m-%d)

range=""
if [[ -n "$LAST_TAG" && "$LAST_TAG" != "0.0.0" ]]; then
  range="${LAST_TAG}..HEAD"
fi

CHANGELOG=$(git log --pretty=format:"- %s (%h)" ${range} | grep -vE '^- Merge pull request' || true)
if [[ -z "$CHANGELOG" ]]; then
  CHANGELOG="- No commits found"
fi

PREV_TAG_NAME=${LAST_TAG:-"initial"}
if [[ -z "$PREV_TAG_NAME" || "$PREV_TAG_NAME" == "0.0.0" ]]; then
  PREV_TAG_NAME="initial"
fi

if [[ -n "${GITHUB_REPOSITORY:-}" && "$PREV_TAG_NAME" != "initial" ]]; then
  FULL_CHANGELOG="https://github.com/${GITHUB_REPOSITORY}/compare/${PREV_TAG_NAME}...${TAG_NAME}"
elif [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
  FULL_CHANGELOG="https://github.com/${GITHUB_REPOSITORY}/commits/${TAG_NAME}"
else
  FULL_CHANGELOG=""
fi

cat <<EOF > release_notes.md
# Release Notes for Version ${TAG_NAME}
**Release Date: ${RELEASE_DATE}**

### What's Changed
${CHANGELOG}

#### Full Changelog: [${PREV_TAG_NAME}...${TAG_NAME}](${FULL_CHANGELOG})
EOF

{
  echo "notes<<EOF"
  cat release_notes.md
  echo "EOF"
  echo "body_path=release_notes.md"
} >> "${GITHUB_OUTPUT:-/dev/null}"
