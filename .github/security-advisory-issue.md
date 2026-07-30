---
title: Unresolved security advisories
labels: security-advisory
---

`pip-audit` reports advisories against the pinned lint and test tooling that
cannot be fixed from CI: this repository has no lockfile to regenerate, so the
remediation is a pinned version bump, which Renovate raises as a pull request.

## Audit output

```text
{{ env.AUDIT_REPORT }}
```
