#!/usr/bin/env bash
set -uo pipefail

: "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"

unresolved=false
report=$(bash "$(dirname "$0")/pip-audit-report.sh" --disable-pip --requirement <(uv export --frozen --all-groups --no-emit-project --format requirements-txt)) || unresolved=true

{
  echo "unresolved=$unresolved"
  echo 'report<<AUDIT_REPORT_EOF'
  echo "$report"
  echo 'AUDIT_REPORT_EOF'
} >>"$GITHUB_OUTPUT"

echo "$report"
echo "advisories unresolved: $unresolved"
