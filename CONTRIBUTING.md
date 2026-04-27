# Contributing to docker-argonone

Thank you for considering a contribution. This document describes how to get started.

## Prerequisites

- Docker with Buildx
- Python 3
- [hadolint](https://github.com/hadolint/hadolint)
- [shfmt](https://github.com/mvdan/sh)
- [ruff](https://docs.astral.sh/ruff/)
- [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)
- A Raspberry Pi or ARM device for testing (or QEMU for emulation)

## Project structure

- `Dockerfile` – container image definition
- `patches/argononed.py` – patched Argon ONE daemon (derived from upstream)
- `patches/argonone-fanconfig.sh` – patched fan configuration script (derived from upstream)
- [`patches/PATCHES.md`](patches/PATCHES.md) – describes every change made to the upstream files and why
- `patches/upstream.sha256` – SHA256 hashes of the upstream files the patches are based on
- `scripts/check-upstream.py` – verifies that upstream files haven't changed
- `scripts/update-upstream.py` – refreshes `patches/upstream.sha256` after updating patches
- `scripts/resolve-version.sh` – determines the next release version from git-cliff output

> The files in `patches/` are modifications of upstream files. Keep changes minimal and focused – do not reformat or restructure them beyond what is necessary for the fix.

## Updating patches

When the CI `upstream-drift` check fails, it means Argon ONE upstream has changed. To update the patches:

1. Download the new upstream files and review the diff against the current `patches/`:

   ```bash
   curl -fsSL https://download.argon40.com/scripts/argononed.py > /tmp/argononed.py
   curl -fsSL https://download.argon40.com/scripts/argonone-fanconfig.sh > /tmp/argonone-fanconfig.sh
   diff /tmp/argononed.py patches/argononed.py
   diff /tmp/argonone-fanconfig.sh patches/argonone-fanconfig.sh
   ```

2. Re-apply the changes documented in [`patches/PATCHES.md`](patches/PATCHES.md) to the new upstream files.
3. Refresh the stored hashes:

   ```bash
   python3 scripts/update-upstream.py
   ```

4. Commit both the updated patch files and `patches/upstream.sha256`.

## Before submitting a PR

Run all checks locally before opening a pull request.

### With tools installed locally

```bash
hadolint Dockerfile
ruff check scripts/ patches/
ruff format --check scripts/
shfmt --diff scripts/
markdownlint-cli2 "**/*.md"
```

### With Docker (no local installs required)

```bash
docker run --rm -v "$(pwd):/src" -w /src hadolint/hadolint hadolint Dockerfile

docker run --rm -v "$(pwd):/src" -w /src ghcr.io/astral-sh/ruff check scripts/ patches/
docker run --rm -v "$(pwd):/src" -w /src ghcr.io/astral-sh/ruff format --check scripts/

docker run --rm -v "$(pwd):/src" -w /src mvdan/shfmt --diff scripts/

docker run --rm -v "$(pwd):/workdir" davidanson/markdownlint-cli2 "**/*.md"
```

The CI runs all of the above plus a Docker smoke build and a vulnerability scan of the resulting image.

## Commit style

This project uses [Conventional Commits](https://www.conventionalcommits.org/). Commit messages drive automatic changelog generation and version bumping.

Common prefixes:

| Prefix      | When to use                         |
| ----------- | ----------------------------------- |
| `feat:`     | New feature or behavior             |
| `fix:`      | Bug fix                             |
| `chore:`    | Maintenance, dependency updates     |
| `refactor:` | Code change without behavior change |
| `docs:`     | Documentation only                  |
| `ci:`       | CI/CD changes                       |

Breaking changes must include `BREAKING CHANGE:` in the commit footer.

## Pull requests

- Keep PRs focused on a single concern.
- Reference any related issue in the PR description.
- All CI checks must pass: Dockerfile linting, Python linting, shell linting, Markdown linting, smoke build, and vulnerability scan.

## Reporting bugs

Open an [issue](https://github.com/wielorzeczownik/docker-argonone/issues) and include:

- What you did
- What you expected
- What actually happened
- Your hardware (Raspberry Pi model, OS)
- Docker version
- Relevant container logs (`docker logs argonone`)

> For security issues, please read [SECURITY.md](SECURITY.md) before opening a public issue.

## License

By contributing you agree that your changes will be licensed under the [MIT License](LICENSE).
