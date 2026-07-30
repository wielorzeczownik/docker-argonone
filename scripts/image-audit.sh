#!/usr/bin/env bash
set -uo pipefail

: "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"

report="${REPORT_FILE:-image-audit-report.txt}"
: >"$report"
unresolved=false

for scan in "$@"; do
  tag="${scan%%=*}"
  json="${scan#*=}"

  {
    echo "### Published image :${tag}"
    echo
  } >>"$report"

  if [[ ! -s "$json" ]]; then
    echo "No trivy report produced, see the workflow logs." >>"$report"
    unresolved=true
    echo >>"$report"
    continue
  fi

  count=$(jq '[.Results[]?.Vulnerabilities[]?] | length' "$json")
  if [[ "$count" -eq 0 ]]; then
    echo "No fixable CRITICAL or HIGH vulnerabilities." >>"$report"
    echo >>"$report"
    continue
  fi

  unresolved=true
  jq -r '
    .Results[]?.Vulnerabilities[]?
    | "- \(.Severity) \(.VulnerabilityID) \(.PkgName) \(.InstalledVersion) -> \(.FixedVersion // "no fix")"
  ' "$json" | sort -u >>"$report"
  echo >>"$report"
done

{
  echo "unresolved=$unresolved"
  echo 'report<<IMAGE_AUDIT_EOF'
  cat "$report"
  echo 'IMAGE_AUDIT_EOF'
} >>"$GITHUB_OUTPUT"

cat "$report"
echo "image advisories unresolved: $unresolved"
