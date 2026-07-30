#!/usr/bin/env bash
set -uo pipefail

: "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"

report="${REPORT_FILE:-audit-report.txt}"
: >"$report"
unresolved=false

if pip-audit \
  --requirement requirements-lint.txt \
  --requirement requirements-test.txt \
  --desc >>"$report" 2>&1; then
  echo "No advisories." >>"$report"
else
  unresolved=true
fi

{
  echo "unresolved=$unresolved"
  echo 'report<<AUDIT_REPORT_EOF'
  cat "$report"
  echo 'AUDIT_REPORT_EOF'
} >>"$GITHUB_OUTPUT"

cat "$report"
echo "advisories unresolved: $unresolved"
