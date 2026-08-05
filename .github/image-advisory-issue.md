---
title: Unresolved image vulnerabilities
labels: image advisory
---

Trivy reports fixable CRITICAL or HIGH vulnerabilities in the published images.
These come from the Ubuntu base image rather than this repository's code, so the
remediation is a base image digest bump, which Renovate raises as a pull
request.

## Scan output

```text
{{ env.IMAGE_REPORT }}
```
