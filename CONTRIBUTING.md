# Contributing to docker-argonone

Thank you for considering a contribution. This document describes how to get started.

## Prerequisites

- Docker with Buildx
- A Raspberry Pi or ARM device for testing (or QEMU for emulation)

## Project structure

- `Dockerfile` - container image definition
- `patches/argononed.py` - patched Argon ONE daemon (derived from upstream)
- `patches/argonone-fanconfig.sh` - patched fan configuration script (derived from upstream)

> The files in `patches/` are modifications of upstream files. Keep changes minimal and focused — do not reformat or restructure them beyond what is necessary for the fix.

## Before submitting a PR

Make sure the Dockerfile lints cleanly:

```bash
docker run --rm -i hadolint/hadolint < Dockerfile
```

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
- The CI `validate` workflow must pass (hadolint + ruff).

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
