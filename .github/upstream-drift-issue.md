---
title: Upstream drift detected
labels: upstream-drift
assignees: {{ env.REPO_OWNER }}
---

One or more upstream files no longer match the hashes in `patches/upstream.sha256`.

## Script output

```text
{{ env.DRIFT_OUTPUT }}
```
