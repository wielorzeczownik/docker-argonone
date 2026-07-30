#!/usr/bin/env bash
set -uo pipefail

: "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"

report="${REPORT_FILE:-drift-report.txt}"
unresolved=false

if ! python3 scripts/check-upstream.py >"$report" 2>&1; then
  unresolved=true
fi

{
  echo "unresolved=$unresolved"
  echo 'report<<DRIFT_REPORT_EOF'
  cat "$report"
  echo 'DRIFT_REPORT_EOF'
} >>"$GITHUB_OUTPUT"

cat "$report"
echo "upstream drift: $unresolved"
