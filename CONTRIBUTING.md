# Contributing to docker-argonone

Thank you for considering a contribution. This document covers everything you need to get started.

## What this project is

This project packages the [Argon ONE](https://www.argon40.com/) fan-control and power-button daemon as a Docker container. The upstream installer script (`argon1.sh`) is downloaded and run during the image build; two of its scripts are patched before shipping to remove artificial fan speed floors that make quiet profiles impossible. See [`patches/PATCHES.md`](patches/PATCHES.md) for the full list of changes and their rationale.

## Project structure

```text
.
├── Dockerfile                    image definition
├── healthcheck.py                container healthcheck script
├── requirements-test.txt         pinned test dependencies
├── patches/
│   ├── argononed.py              patched Argon ONE daemon (derived from upstream)
│   ├── argonone-fanconfig.sh     patched fan config tool (derived from upstream)
│   ├── PATCHES.md                documents every change and why
│   └── upstream.sha256           SHA-256 hashes of the upstream files
├── scripts/
│   ├── check-upstream.py         verifies upstream files have not changed
│   ├── update-upstream.py        refreshes upstream.sha256 after updating patches
│   └── resolve-version.sh        determines next release version from git-cliff
└── tests/
    ├── conftest.py               mocks argon hardware modules for unit tests
    └── test_argononed.py         unit tests for patched daemon logic
```

> Files in `patches/` are modifications of upstream files. Keep changes minimal and focused — do not reformat or restructure beyond what is necessary.

## Development setup

```bash
git clone https://github.com/wielorzeczownik/docker-argonone.git
cd docker-argonone
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements-test.txt
```

## Running checks locally

### With tools installed locally

```bash
# Dockerfile
hadolint Dockerfile

# Python
ruff check scripts/ patches/ tests/ healthcheck.py
ruff format --check scripts/ healthcheck.py

# Shell
shfmt --diff scripts/

# Markdown
markdownlint-cli2 "**/*.md"
```

### With Docker (no local installs required)

```bash
docker run --rm -v "$(pwd):/src" -w /src hadolint/hadolint hadolint Dockerfile

docker run --rm -v "$(pwd):/src" -w /src ghcr.io/astral-sh/ruff check scripts/ patches/ tests/ healthcheck.py
docker run --rm -v "$(pwd):/src" -w /src ghcr.io/astral-sh/ruff format --check scripts/ healthcheck.py

docker run --rm -v "$(pwd):/src" -w /src mvdan/shfmt --diff scripts/

docker run --rm -v "$(pwd):/workdir" davidanson/markdownlint-cli2 "**/*.md"
```

## Running tests

The unit tests cover the patched daemon logic (`get_fanspeed`, `load_config`) without requiring real hardware. Hardware modules are mocked in `tests/conftest.py`.

```bash
source .venv/bin/activate
pytest tests/ -v
```

## Updating patches

When the CI `upstream-drift` check fails, the upstream Argon ONE scripts have changed. To update:

1. Download the new upstream files and diff them against the current patches:

   ```bash
   curl -fsSL https://download.argon40.com/scripts/argononed.py > /tmp/argononed.py
   curl -fsSL https://download.argon40.com/scripts/argonone-fanconfig.sh > /tmp/argonone-fanconfig.sh
   diff /tmp/argononed.py patches/argononed.py
   diff /tmp/argonone-fanconfig.sh patches/argonone-fanconfig.sh
   ```

2. Re-apply every change described in [`patches/PATCHES.md`](patches/PATCHES.md) to the new upstream files.

3. Refresh the stored hashes:

   ```bash
   python3 scripts/update-upstream.py
   ```

4. Commit the updated patch files and `patches/upstream.sha256` together.

## Commit style

This project uses [Conventional Commits](https://www.conventionalcommits.org/). Commit messages drive automatic changelog generation and version bumping.

| Prefix      | When to use                         |
| ----------- | ----------------------------------- |
| `feat:`     | New feature or behavior             |
| `fix:`      | Bug fix                             |
| `test:`     | Adding or updating tests            |
| `chore:`    | Maintenance, dependency updates     |
| `refactor:` | Code change without behavior change |
| `docs:`     | Documentation only                  |
| `ci:`       | CI/CD changes                       |

Breaking changes must include `BREAKING CHANGE:` in the commit footer.

Keep commits focused on a single concern. If a change touches both logic and tests, a single commit is fine — if it touches unrelated areas, split it.

## Pull requests

- Keep PRs focused on a single concern.
- Reference any related issue in the PR description.
- All CI checks must pass before merging: Dockerfile linting, Python linting, shell formatting, Markdown linting, unit tests, smoke build, and vulnerability scan.

## Reporting bugs

Open an [issue](https://github.com/wielorzeczownik/docker-argonone/issues) and include:

- What you did
- What you expected
- What actually happened
- Your hardware (Raspberry Pi model, OS)
- Docker version
- Relevant container logs (`docker logs argonone`)

> For security issues, read [SECURITY.md](SECURITY.md) before opening a public issue.

## License

By contributing you agree that your changes will be licensed under the [MIT License](LICENSE).
