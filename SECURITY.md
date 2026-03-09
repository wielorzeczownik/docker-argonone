# Security Policy

## Supported versions

Only the latest release receives security fixes.

## Reporting a vulnerability

**Do not open a public GitHub issue for security vulnerabilities.**

Report vulnerabilities privately via [GitHub Security Advisories](https://github.com/wielorzeczownik/docker-argonone/security/advisories/new).

Include as much detail as possible:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

You will receive a response within **7 days**. If the issue is confirmed, a fix will be released as soon as possible and you will be credited in the release notes (unless you prefer to remain anonymous).

## Scope

This project runs a privileged Docker container with access to I2C hardware. The attack surface includes:

- The container runs with `--privileged` and access to `/dev/i2c-1`
- The daemon communicates with hardware via I2C

Issues related to the upstream Argon ONE daemon or the original scripts are out of scope.

## Security notes

- The container requires privileged access to communicate with hardware.
- Keep the base image up to date.
