#!/usr/bin/env bash
set -uo pipefail

errors=$(mktemp)
audit=$(pip-audit --format json --progress-spinner off "$@" 2>"$errors")

if ! jq -e '.dependencies' <<<"$audit" >/dev/null 2>&1; then
  printf '## pip-audit Report\n\n⚠️ pip-audit could not run: %s\n' "$(tail -n 1 "$errors")"
  exit 1
fi

jq -r '
  [.dependencies[] | select((.vulns // []) | length > 0)] as $hit
  | ([$hit[].vulns[]] | length) as $total
  | "## pip-audit Report", "",
    "### Summary", "",
    "- **Dependencies:** \([.dependencies[] | select(.skip_reason | not)] | length) checked",
    (if $total == 0 then "- **Advisories:** ✅ none" else "- **Advisories:** ❌ \($total) total" end),
    (if $total > 0 then
       "", "### Advisories", "",
       "| Package | Severity | Advisory | Fix |",
       "| --- | --- | --- | --- |",
       ($hit[] | .name as $name | .version as $version | .vulns[]
        | "| `\($name)` \($version) | n/a | [\(.id)](https://osv.dev/vulnerability/\(.id))\(if (.aliases | length) > 0 then " (" + (.aliases | join(", ")) + ")" else "" end) | \(if (.fix_versions | length) > 0 then (.fix_versions | map("`\(.)`") | join(", ")) else "none" end) |")
     else empty end)
' <<<"$audit"

[[ "$(jq '[.dependencies[] | (.vulns // []) | length] | add // 0' <<<"$audit")" == 0 ]]
