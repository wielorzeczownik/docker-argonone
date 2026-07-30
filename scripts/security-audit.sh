#!/usr/bin/env bash
set -uo pipefail

: "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"

report="${REPORT_FILE:-audit-report.txt}"
: >"$report"
unresolved=false

{
  echo "### Python tooling (pip-audit)"
  echo
} >>"$report"

if pip-audit \
  --requirement requirements-lint.txt \
  --requirement requirements-test.txt \
  --desc >>"$report" 2>&1; then
  echo "No advisories." >>"$report"
else
  unresolved=true
fi

for scan in "$@"; do
  tag="${scan%%=*}"
  json="${scan#*=}"

  {
    echo
    echo "### Published image :${tag} (trivy)"
    echo
  } >>"$report"

  if [[ ! -s "$json" ]]; then
    echo "No trivy report produced, see the workflow logs." >>"$report"
    unresolved=true
    continue
  fi

  count=$(jq '[.Results[]?.Vulnerabilities[]?] | length' "$json")
  if [[ "$count" -eq 0 ]]; then
    echo "No fixable CRITICAL or HIGH vulnerabilities." >>"$report"
    continue
  fi

  unresolved=true
  jq -r '
    .Results[]?.Vulnerabilities[]?
    | "- \(.Severity) \(.VulnerabilityID) \(.PkgName) \(.InstalledVersion) -> \(.FixedVersion // "no fix")"
  ' "$json" | sort -u >>"$report"
done

{
  echo "unresolved=$unresolved"
  echo 'report<<AUDIT_REPORT_EOF'
  cat "$report"
  echo 'AUDIT_REPORT_EOF'
} >>"$GITHUB_OUTPUT"

cat "$report"
echo "advisories unresolved: $unresolved"
