---
title: Upstream drift detected
labels: upstream-drift
---

One or more upstream files no longer match the hashes in
`patches/upstream.sha256`. Re-apply every change listed in
[`patches/PATCHES.md`](../blob/master/patches/PATCHES.md) to the new upstream
files, then refresh the hashes with `python3 scripts/update-upstream.py`.

## Script output

```text
{{ env.DRIFT_REPORT }}
```
