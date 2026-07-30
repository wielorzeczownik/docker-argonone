---
title: Unresolved security advisories
labels: security-advisory
---

`pip-audit` or the Trivy scan of the published images reports advisories that
cannot be fixed from CI: this repository has no lockfile to regenerate, so
remediation is either a base image digest bump or a pinned tool bump, both of
which Renovate raises as pull requests.

## Audit output

```text
{{ env.AUDIT_REPORT }}
```
