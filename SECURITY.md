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

This project runs a Docker container with direct access to hardware devices. The attack surface includes:

- The container accesses `/dev/i2c-1` (fan/MCU communication) and `/dev/gpiochip0` or `/dev/gpiochip4` (power button GPIO)
- The daemon communicates with hardware via I2C
- The daemon runs as root (PID 1) inside the container

Issues related to the upstream Argon ONE daemon or the original scripts are out of scope.

## Security notes

- The container does not require `--privileged`; grant only the specific device nodes it needs.
- Keep the base image up to date.
