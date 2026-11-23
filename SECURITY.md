# Security

Thanks for taking the time to look. Please report vulnerabilities privately through [GitHub Security Advisories](https://github.com/wielorzeczownik/docker-argonone/security/advisories/new) instead of a public issue, so there's a chance to fix them first. You'll be credited in the release notes unless you'd rather not be. Only the latest release gets fixes.

## In scope

The container talks to hardware directly, so the scope is:

- access to `/dev/i2c-1` (fan and MCU) and `/dev/gpiochip0` or `/dev/gpiochip4` (power button)
- the daemon running as root (PID 1 in the standard image, under systemd in the systemd image)
- the systemd image, which runs with `--privileged` so the power button can shut the host down

Problems in the upstream Argon ONE daemon or its original scripts are out of scope.

## Running it safely

- Prefer the standard image. It doesn't need `--privileged`, only the device nodes listed above.
- Use the systemd image only if you need power-button shutdown, since `--privileged` gives it broad access to the host.
- Keep the image up to date.
