# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### CI/CD

- Adopt strict ruff and mypy rules for scripts and tests ([72baba0](https://github.com/wielorzeczownik/docker-argonone/commit/72baba094c93652e89ae44dfb6cd30c985130533))

## [2.0.6](https://github.com/wielorzeczownik/docker-argonone/compare/v2.0.5...v2.0.6) - 2026-06-27

### CI/CD

- Update softprops/action-gh-release action to v3.0.1 ([4a1c622](https://github.com/wielorzeczownik/docker-argonone/commit/4a1c622f5905771059296af5c5fa21c93dcae3be))
- Update actions/checkout action to v7 ([a547f1c](https://github.com/wielorzeczownik/docker-argonone/commit/a547f1cf8cc9658740a233f0bede172177ef9110))
- Update actions/checkout action to v6.0.3 ([53d33c3](https://github.com/wielorzeczownik/docker-argonone/commit/53d33c3f5f20232928999519e237b2618b55e5a7))
- Update docker actions to v4.1.0 ([2dc6b19](https://github.com/wielorzeczownik/docker-argonone/commit/2dc6b193c5ca4c3aa9a1c9fb619d84320a8d910e))
- Update renovate.json ([d4f8448](https://github.com/wielorzeczownik/docker-argonone/commit/d4f844866222a439e243c707d61ab507b8fecb68))
- Update docker actions ([26b5dd4](https://github.com/wielorzeczownik/docker-argonone/commit/26b5dd41ef264dc2a6da18c3ad4ebd1cabe79094))
- Update docker/build-push-action action to v7.2.0 ([68d1f4d](https://github.com/wielorzeczownik/docker-argonone/commit/68d1f4db0055bf7417ed009e2c88b97c5aca4802))
- Update davidanson/markdownlint-cli2-action action to v23.2.0 ([bd578e7](https://github.com/wielorzeczownik/docker-argonone/commit/bd578e705890bc5789e491fb976e04bc66af9bab))

### Dependencies

- Update ubuntu:26.04 docker digest to 53958ec ([ee0b34f](https://github.com/wielorzeczownik/docker-argonone/commit/ee0b34fbad16aa8990eb43aa85432d04ba715a63))
- Update dependency pytest to v9.1.1 ([3f98b4c](https://github.com/wielorzeczownik/docker-argonone/commit/3f98b4cc6af5bf974844e54508b2491a0f2e85f2))

## [2.0.5](https://github.com/wielorzeczownik/docker-argonone/compare/v2.0.4...v2.0.5) - 2026-05-06

### Documentation

- Rename 'What this project is' section to Overview ([5f6d739](https://github.com/wielorzeczownik/docker-argonone/commit/5f6d73933c58a9752ff6111ea71555a685dd9379))
- Rewrite contributing guide ([208a72a](https://github.com/wielorzeczownik/docker-argonone/commit/208a72a44c05b39adb6bff313e970e10eb2e307d))
- Simplify PR template, drop redundant type of change ([8171147](https://github.com/wielorzeczownik/docker-argonone/commit/8171147d06c5c1eb7300679ebb379e956d8ee1eb))
- Simplify PR template, drop redundant type of change ([1b25062](https://github.com/wielorzeczownik/docker-argonone/commit/1b2506204efc7844a447258186855b4113ab580b))

### Testing

- Add pinned pytest dependency and document test commands ([fcb9908](https://github.com/wielorzeczownik/docker-argonone/commit/fcb9908cd388c6fd5cdd936d50f7e819172eb7c5))
- Add pytest unit tests for patched get_fanspeed and load_config ([0a12970](https://github.com/wielorzeczownik/docker-argonone/commit/0a12970543ed42642303d42c3ce87a6cc87417db))
- Add pytest unit tests, dependency, and CI job ([2f5e083](https://github.com/wielorzeczownik/docker-argonone/commit/2f5e083fef74dd9c5cc4d1fe0dac9d7ea4502cfa))

### CI/CD

- Update davidanson/markdownlint-cli2-action action to v23.1.0 ([64d4c9c](https://github.com/wielorzeczownik/docker-argonone/commit/64d4c9c6769c8a1f262df36f486118ab08b9668d))
- Update aquasecurity/trivy-action action to v0.36.0 ([640b419](https://github.com/wielorzeczownik/docker-argonone/commit/640b419229473d1261445c50087ce264e02a2179))

### Dependencies

- Update ubuntu:24.04 docker digest ([7118b4f](https://github.com/wielorzeczownik/docker-argonone/commit/7118b4f08a063cdcb7dad78c19afb467eda7585e))

## [2.0.4](https://github.com/wielorzeczownik/docker-argonone/compare/v2.0.3...v2.0.4) - 2026-05-01

### Bug Fixes

- Use context managers in healthcheck ([a110e70](https://github.com/wielorzeczownik/docker-argonone/commit/a110e70808f31312933b0d37ae6c013fe156cb6b))

### Refactoring

- Extract healthcheck inline script to healthcheck.py ([76e65b4](https://github.com/wielorzeczownik/docker-argonone/commit/76e65b443a62ae02b02ac96336358eb347cdace5))

### Documentation

- Update pull_request_template.md ([ec58e8a](https://github.com/wielorzeczownik/docker-argonone/commit/ec58e8a339c31d4665f285ce2b482f510ff0a228))

### CI/CD

- Suppress DL3008 inline in Dockerfile ([7193330](https://github.com/wielorzeczownik/docker-argonone/commit/71933306fad1716b5a38cd81567a65ca24f9661d))
- Pass hadolint config path to lint action ([2979c36](https://github.com/wielorzeczownik/docker-argonone/commit/2979c36937dea12b835c9d4142ea16d318c1fa83))

### Miscellaneous

- Merge stubs+install layer, purge build-time tools, use COPY --chmod ([9cfe7e0](https://github.com/wielorzeczownik/docker-argonone/commit/9cfe7e01b85752e5048c25c8c33b4b657ddb14c9))
- Replace curl with wget, drop curl dependency ([59c699e](https://github.com/wielorzeczownik/docker-argonone/commit/59c699e6ef02fa72995889f2c753bd315abcfb36))

## [2.0.3](https://github.com/wielorzeczownik/docker-argonone/compare/v2.0.2...v2.0.3) - 2026-04-27

### Refactoring

- Extract release version bump logic to separate script ([8727bd0](https://github.com/wielorzeczownik/docker-argonone/commit/8727bd009af9956a6a18d9baec016499124b32fb))

### Documentation

- Update enforcement contact to private channel ([bc87d0f](https://github.com/wielorzeczownik/docker-argonone/commit/bc87d0f7186cb179a4480d59b9aee0c60b58b649))
- Update PR checklist to reflect current CI checks ([db0dc56](https://github.com/wielorzeczownik/docker-argonone/commit/db0dc5633aa7946f9c976ee056b62252b1550f18))
- Update contributing guide with full tool list and check commands ([79d7bf3](https://github.com/wielorzeczownik/docker-argonone/commit/79d7bf334183c5ff0923b8c5d83fe479d8580bf1))
- Fix existing violations ([8c5c677](https://github.com/wielorzeczownik/docker-argonone/commit/8c5c677a0cdc2d9a34ba4c705d7a9de533662eb0))
- Update README.md ([4162c32](https://github.com/wielorzeczownik/docker-argonone/commit/4162c32317c46c3b20b5bdb23fad5a8201b4cd48))

### CI/CD

- Pin actions and add timeouts to upstream-drift workflow ([5469ce3](https://github.com/wielorzeczownik/docker-argonone/commit/5469ce35617164882cdae3d364e864efcd647231))
- Harden release workflow with pinned actions, permissions, and SBOM attestation ([83bfc22](https://github.com/wielorzeczownik/docker-argonone/commit/83bfc228c341149d7570ccef6627ba87173ba67a))
- Harden validate workflow with pinned actions, Trivy scan, and shfmt-only linting ([b66feb3](https://github.com/wielorzeczownik/docker-argonone/commit/b66feb3d3b5b468a5f56fff5808a972a2154cae9))
- Configure Renovate with stability delays, grouping, and digest pinning ([2ffa625](https://github.com/wielorzeczownik/docker-argonone/commit/2ffa625ffe71ec178a13a18fed2af324bb981134))
- Update davidanson/markdownlint-cli2-action action to v23 ([c7a9093](https://github.com/wielorzeczownik/docker-argonone/commit/c7a9093a147aeb5fb206d38d3a83c50e1c1cbed5))
- Use correct shellcheck action version tag ([9cbebbe](https://github.com/wielorzeczownik/docker-argonone/commit/9cbebbee3b480090f9d4ca1e30d3091b7fecef38))
- Update mfinelli/setup-shfmt action to v4 ([283147c](https://github.com/wielorzeczownik/docker-argonone/commit/283147cb559f59a4d9ee8734e806e1222a7992c3))
- Use correct shellcheck action version tag ([f422197](https://github.com/wielorzeczownik/docker-argonone/commit/f422197c2077a9cf34192a0503225638b65b65b6))
- Add markdownlint and fix existing violations ([fecabe8](https://github.com/wielorzeczownik/docker-argonone/commit/fecabe8612f3a07aa8e302a063278bd26a31cff3))
- Add ShellCheck and shfmt linting for shell scripts ([75faf15](https://github.com/wielorzeczownik/docker-argonone/commit/75faf153f62cf8b42dfc6a4da5563452b48131fc))
- Update astral-sh/ruff-action action to v4 ([cb922cd](https://github.com/wielorzeczownik/docker-argonone/commit/cb922cdfa4ee91326bce2768676ec51bf0c9c8a3))

### Miscellaneous

- Rename .prettierrc.json to .prettierrc ([3647736](https://github.com/wielorzeczownik/docker-argonone/commit/36477361df7f09d8000d07f947a0d1f3d20d8c65))
- Add hadolint config file and enable pipefail shell option ([ccb4318](https://github.com/wielorzeczownik/docker-argonone/commit/ccb4318f644afdfe9491bff1e5adeb09828e48d6))

## [2.0.2](https://github.com/wielorzeczownik/docker-argonone/compare/v2.0.1...v2.0.2) - 2026-04-26

### Bug Fixes

- Remove config hot-reload ([b69f669](https://github.com/wielorzeczownik/docker-argonone/commit/b69f6698e1bc09bb5d926007fddc8dc0bb0c12a0))

## [2.0.1](https://github.com/wielorzeczownik/docker-argonone/compare/v2.0.0...v2.0.1) - 2026-04-26

### Bug Fixes

- Update prevspeed only after successful I2C write ([4295121](https://github.com/wielorzeczownik/docker-argonone/commit/4295121a047a0de3dabf2bfac640426f84548f6b))

### Documentation

- Update power button note to reference v2.0.0 ([607da42](https://github.com/wielorzeczownik/docker-argonone/commit/607da428a91fcbcdb1e223a21b0acbe7d7f69cbc))

### CI/CD

- Add GHA layer cache to smoke-build and release ([877db3d](https://github.com/wielorzeczownik/docker-argonone/commit/877db3d4803a2f52fdce8e8b5e9f40134d0130b0))

## [2.0.0](https://github.com/wielorzeczownik/docker-argonone/compare/v1.1.0...v2.0.0) - 2026-04-26

### Features

- Replace systemd with direct Python daemon as PID 1 ([e347ac0](https://github.com/wielorzeczownik/docker-argonone/commit/e347ac03bea4f3ceb350bd0151d116505c04147c))

### Documentation

- Update README and SECURITY for direct process execution ([c64fdcd](https://github.com/wielorzeczownik/docker-argonone/commit/c64fdcdbb808a44b5aeb8c653a3b0ad47a387fee))

### CI/CD

- Exclude patches/ from root ruff format check ([5066f16](https://github.com/wielorzeczownik/docker-argonone/commit/5066f164258e792b7d9eaeb6a4cc0ce800676aeb))
- Fix ruff-action ([7cf636e](https://github.com/wielorzeczownik/docker-argonone/commit/7cf636e53c6e39c4e9c8a36201b88fc5a419ee83))

## [1.1.0](https://github.com/wielorzeczownik/docker-argonone/compare/v1.0.7...v1.1.0) - 2026-04-26

### Features

- Log CPU temperature and fan speed to container stdout ([17eb9fc](https://github.com/wielorzeczownik/docker-argonone/commit/17eb9fce0371e56a0e78d5c5638fd0e6659dfb17))

### Documentation

- Add PATCHES.md and reference it from CONTRIBUTING ([de840ef](https://github.com/wielorzeczownik/docker-argonone/commit/de840ef270067ee7caffa6f4a8f70ea77ea249ad))

### CI/CD

- Add ruff linting and Docker smoke build to validate workflow ([eda8952](https://github.com/wielorzeczownik/docker-argonone/commit/eda89526ff6bef29cec7f3f07e4397d411820569))

## [1.0.7](https://github.com/wielorzeczownik/docker-argonone/compare/v1.0.6...v1.0.7) - 2026-04-23

### Dependencies

- Update ubuntu docker tag to resolute-20260413 (#42) ([d294d0a](https://github.com/wielorzeczownik/docker-argonone/commit/d294d0a5fe423d912e794beedb1ae2cec5074741))

## [1.0.6](https://github.com/wielorzeczownik/docker-argonone/compare/v1.0.5...v1.0.6) - 2026-04-23

### Dependencies

- Migrate base images from 24 to 26 ([58067b5](https://github.com/wielorzeczownik/docker-argonone/commit/58067b54046b226be034e2c265c2983139362a8d))

### Miscellaneous

- Add OCI image labels ([8fe76ca](https://github.com/wielorzeczownik/docker-argonone/commit/8fe76caf51c119ec5fa49ec80f86df892367e0c1))

## [1.0.5](https://github.com/wielorzeczownik/docker-argonone/compare/v1.0.4...v1.0.5) - 2026-04-16

### Documentation

- Add logo ([270ab5c](https://github.com/wielorzeczownik/docker-argonone/commit/270ab5c4de4593e6dd31980ea6482dc6c7806ef0))
- Add logo ([98358af](https://github.com/wielorzeczownik/docker-argonone/commit/98358af000bb16a24164df69c69294db4d96fef5))
- Document upstream patch update process ([535cebc](https://github.com/wielorzeczownik/docker-argonone/commit/535cebcb76651700c32f615d8a46818c623490f0))

### CI/CD

- Update softprops/action-gh-release action to v3 ([259adbe](https://github.com/wielorzeczownik/docker-argonone/commit/259adbe11022b7ef69c4a9c52113c9ac9977f215))
- Add daily upstream drift detection with auto issue creation ([770ea0e](https://github.com/wielorzeczownik/docker-argonone/commit/770ea0e786877eb0677a59f7e601923a021a0a9d))
- Add upstream-drift job to validate workflow ([1c091cd](https://github.com/wielorzeczownik/docker-argonone/commit/1c091cd0d852aed65ad2867c994da82eb17111c2))
- Add upstream drift check and hash update scripts ([4a24188](https://github.com/wielorzeczownik/docker-argonone/commit/4a24188736935639c203867fa9df5471fe023d9a))

### Dependencies

- Update ubuntu:24.04 docker digest to c4a8d55 ([afefba3](https://github.com/wielorzeczownik/docker-argonone/commit/afefba398ab4559e64aea9a0f4341c0116d53c10))

### Miscellaneous

- Add ruff configuration ([41d0376](https://github.com/wielorzeczownik/docker-argonone/commit/41d0376beac0bdbd86a28dd29c70433fc4ef7648))
- Add upstream SHA256 hashfile for drift detection ([d038fe7](https://github.com/wielorzeczownik/docker-argonone/commit/d038fe7e2a6906d3de6232ac3518d63451d2ceb3))

## [1.0.4](https://github.com/wielorzeczownik/docker-argonone/compare/v1.0.3...v1.0.4) - 2026-04-07

### Documentation

- Update CONTRIBUTING.md ([bdeed69](https://github.com/wielorzeczownik/docker-argonone/commit/bdeed69d0dfb4e288b8a7fad7ccbb832635b4683))

### Styling

- Delete ruff.toml ([8b734bd](https://github.com/wielorzeczownik/docker-argonone/commit/8b734bd8bc882fc09cc7eb1d262c579ba2f3fb53))

### CI/CD

- Update validate.yml ([91da1d1](https://github.com/wielorzeczownik/docker-argonone/commit/91da1d128151061fedd7b2fe8a46fce8c726d79b))

### Dependencies

- Update ubuntu:24.04 docker digest to 84e77de ([7fa85ed](https://github.com/wielorzeczownik/docker-argonone/commit/7fa85ed74cd808b6d1b883ac31bcc31441a6aed5))

## [1.0.3](https://github.com/wielorzeczownik/docker-argonone/compare/v1.0.2...v1.0.3) - 2026-04-06

### Styling

- Update label ([59aa5fb](https://github.com/wielorzeczownik/docker-argonone/commit/59aa5fb63f37627021a38024548522d3723cc632))
- Update label ([640c8fe](https://github.com/wielorzeczownik/docker-argonone/commit/640c8fe616d20e110ed408175ed6baba6815ca03))

### CI/CD

- Configure Renovate digest pinning ([1be1467](https://github.com/wielorzeczownik/docker-argonone/commit/1be146747a5ed343c4c307b984f055024abb308a))

### Dependencies

- Pin ubuntu base image to digest ([f1179e6](https://github.com/wielorzeczownik/docker-argonone/commit/f1179e668911a283d7bb551a3eb2a605ef832c2c))

### Miscellaneous

- Enable digest pinning for Dockerfile base image ([7c51cf7](https://github.com/wielorzeczownik/docker-argonone/commit/7c51cf75ceb68bff7ef549caf653cfc390560b7f))

## [1.0.2](https://github.com/wielorzeczownik/docker-argonone/compare/v1.0.1...v1.0.2) - 2026-04-06

### Documentation

- Add ruff lint instructions to CONTRIBUTING ([e8d11a3](https://github.com/wielorzeczownik/docker-argonone/commit/e8d11a3a8958a1eb5b84a3c557d5980f0d90aaa6))
- Update README with Raspberry Pi 5 support and SEO improvements ([b5ae00b](https://github.com/wielorzeczownik/docker-argonone/commit/b5ae00b301b2e669422bf12cdc9cd2ab4391c462))

### Styling

- Reformat argononed.py with ruff ([c5a03c6](https://github.com/wielorzeczownik/docker-argonone/commit/c5a03c6511e55eb8d70ad2e2b5e860e20c9ffa36))

### CI/CD

- Remove skip ci condition ([6bee429](https://github.com/wielorzeczownik/docker-argonone/commit/6bee42943ad56a89cbd91bb4c7c2b88ec432b26f))
- Migrate lint to validate workflow and add ruff check ([7413b94](https://github.com/wielorzeczownik/docker-argonone/commit/7413b946b817c500ee2f85f4129690424c9d0192))

### Dependencies

- Update hadolint/hadolint-action action to v3.3.0 ([9c3ccd9](https://github.com/wielorzeczownik/docker-argonone/commit/9c3ccd920eec664104c49fca96002b2b653399c4))

### Miscellaneous

- Add ruff check ([3fd633b](https://github.com/wielorzeczownik/docker-argonone/commit/3fd633b6c4189f9c1fe461510efa2586db9fcf48))
- Add .ruff_cache to .gitignore ([1f6e8be](https://github.com/wielorzeczownik/docker-argonone/commit/1f6e8bec3923db6bb735ac755f34db4e8f64ad89))
- Update .dockerignore to exclude non-build files ([29c2615](https://github.com/wielorzeczownik/docker-argonone/commit/29c261574bd7f678ffd3d65cef58e8ff4b49df24))
- Set semantic commit type for github-actions in renovate ([b940189](https://github.com/wielorzeczownik/docker-argonone/commit/b9401890e6b7946c990d47c45d0166ee3bfcd417))
- Rename .prettierrc to .prettierrc.json ([bd3ad54](https://github.com/wielorzeczownik/docker-argonone/commit/bd3ad54ed54f9a3a3e15bcc6ff9b5976f76d0088))
- Add ruff configuration ([8620f29](https://github.com/wielorzeczownik/docker-argonone/commit/8620f291ff9d06570240ffdee3dd2c4589d19f74))

## [1.0.1](https://github.com/wielorzeczownik/docker-argonone/compare/v1.0.0...v1.0.1) - 2026-03-09

### Bug Fixes

- Silence hadolint warnings (DL3008, DL4006, SC2038, DL3059) ([ad6772a](https://github.com/wielorzeczownik/docker-argonone/commit/ad6772a5e8d94c7b5a97e7aaebf8a81c26496913))
- Sync cliff.toml fixes and add downgrade guard ([3863fa7](https://github.com/wielorzeczownik/docker-argonone/commit/3863fa7f75df2603eb44d6aa19f087c763a68f5d))
- Move version title into changelog body template ([86fd750](https://github.com/wielorzeczownik/docker-argonone/commit/86fd7507110bcabd949f6ed379af920b864216ce))

### Documentation

- Add CONTRIBUTING, SECURITY, and CODE_OF_CONDUCT ([9ad5c3a](https://github.com/wielorzeczownik/docker-argonone/commit/9ad5c3a55c6370c1749af805c0cbc4ecf8823346))
- Update badges ([74462cd](https://github.com/wielorzeczownik/docker-argonone/commit/74462cde9d0efea1b777011a4d741fb5ae669448))
- Update license link ([a71206a](https://github.com/wielorzeczownik/docker-argonone/commit/a71206a605bba0d4c9b3d5bdaef41367ae17ca10))
- Update license badge link ([305dd57](https://github.com/wielorzeczownik/docker-argonone/commit/305dd575bdc5a664fd0bb2f759ea6db6e6b3f403))
- Streamline badge links in README.md ([7523ae6](https://github.com/wielorzeczownik/docker-argonone/commit/7523ae6a811fcd5a24713280aefd506a83ee52ff))

### CI/CD

- Add hadolint Dockerfile linting on pull request ([d08b6c4](https://github.com/wielorzeczownik/docker-argonone/commit/d08b6c4ccd53360ee869c2c7d454cd6530a56deb))
- Migrate release workflow to git-cliff ([08cf115](https://github.com/wielorzeczownik/docker-argonone/commit/08cf115c75a0b37d2c31dabbb8db1fbc26c52ffb))

### Dependencies

- Update docker/build-push-action action to v7 ([8ef6d0c](https://github.com/wielorzeczownik/docker-argonone/commit/8ef6d0cef39123a8332460a90d7998e893bca83b))
- Update docker/setup-buildx-action action to v4 ([3c4966d](https://github.com/wielorzeczownik/docker-argonone/commit/3c4966d014d1322d62d98edad564812f7404856a))
- Update docker/metadata-action action to v6 ([f8a53fa](https://github.com/wielorzeczownik/docker-argonone/commit/f8a53faeff200ee62cd448a3a5e941a30c08ef9b))
- Update docker/login-action action to v4 ([e0a6e3e](https://github.com/wielorzeczownik/docker-argonone/commit/e0a6e3e18f3952698298b0836fa34de345e0548f))
- Update docker/setup-qemu-action action to v4 ([3837e3a](https://github.com/wielorzeczownik/docker-argonone/commit/3837e3a18e188db0cc4523cf32b607640edaee1e))
- Update actions/download-artifact action to v8 ([300cf28](https://github.com/wielorzeczownik/docker-argonone/commit/300cf28414d04e1cd380c0beda386608c1251c0d))
- Update actions/upload-artifact action to v7 ([addec12](https://github.com/wielorzeczownik/docker-argonone/commit/addec12840d3005ecbd98bcd0cc11546d2da5351))
- Update softprops/action-gh-release action to v2 ([21a5d7e](https://github.com/wielorzeczownik/docker-argonone/commit/21a5d7e8964df28d70dd49aa413cdc93cd3ee7b7))
- Update actions/checkout action to v6 ([9fd0555](https://github.com/wielorzeczownik/docker-argonone/commit/9fd05555cd67b1ab15f55dd60cb9a2f9be741801))
- Update dependency ubuntu to v24 ([f977688](https://github.com/wielorzeczownik/docker-argonone/commit/f97768898232ed670e11468f385ff774524ada2b))

### Miscellaneous

- Add issue templates, PR template, and CODEOWNERS ([90e9316](https://github.com/wielorzeczownik/docker-argonone/commit/90e9316f9e9980a098e99966d427abae0da0bea4))
- Improve changelog template and commit filtering ([1104eb2](https://github.com/wielorzeczownik/docker-argonone/commit/1104eb242aa83ed4d8742aead2a1eb79176c9e4f))
- Replace Beerware License with MIT License ([4808226](https://github.com/wielorzeczownik/docker-argonone/commit/4808226ef85caf21bb69530b8493cdb622546a6a))

## [1.0.0](https://github.com/wielorzeczownik/docker-argonone/compare/v0.0.14...v1.0.0) - 2025-11-26

### Features

- Improve release notes generation and tag handling ([8a569a1](https://github.com/wielorzeczownik/docker-argonone/commit/8a569a1ff3a9c3fdb01466be98e81d1b2fdf9ce1))
- Allow low-duty fan config and document patches ([ccf9102](https://github.com/wielorzeczownik/docker-argonone/commit/ccf910289bb8b65141c206ddcfed2c1775c9d236))

### Bug Fixes

- Remove single-quoted heredoc to allow variable expansion in notes block ([3f21656](https://github.com/wielorzeczownik/docker-argonone/commit/3f21656b775b84a7f91d4329bbd0e4af92179d32))
- Prefix last_tag with v in release notes script ([4d8e611](https://github.com/wielorzeczownik/docker-argonone/commit/4d8e611414554ad8d2fc84d3432388d4866663b8))

### Documentation

- Tidy README formatting and compose examples ([976b5eb](https://github.com/wielorzeczownik/docker-argonone/commit/976b5ebe1d0579784f07427e6f7288f8a0ee8a57))
- Refresh README with theme-aware badges and clarified usage ([0b70ee2](https://github.com/wielorzeczownik/docker-argonone/commit/0b70ee225e9fabf735e747d97cde5c5bc26ca36d))

### CI/CD

- Harden output handling and tweak release notes invocation ([573dc15](https://github.com/wielorzeczownik/docker-argonone/commit/573dc15150cca279226117a781e73f19d5264546))
- Let Dockerfile change detection use tag-based default base ([449f7b4](https://github.com/wielorzeczownik/docker-argonone/commit/449f7b4ab02f3dfef5bd1796bf47a0463483ff5c))
- Improve release diff detection and generate release notes file ([e70fd83](https://github.com/wielorzeczownik/docker-argonone/commit/e70fd839586ceb823733973c2682f9afb4ab614f))
- Diff Dockerfile changes from last tag and bump accordingly ([6399710](https://github.com/wielorzeczownik/docker-argonone/commit/63997107beb6df0d7074836c0f42a2e051b2a906))
- Handle v-prefixed tags in version bump script ([5a874ee](https://github.com/wielorzeczownik/docker-argonone/commit/5a874eeb240fbb574129e373003af9f57e7a4785))
- Add auto-release workflow and tooling configs ([8aad7aa](https://github.com/wielorzeczownik/docker-argonone/commit/8aad7aab68896138745f5c8b53fe7ec6f82d2138))

## [0.0.14](https://github.com/wielorzeczownik/docker-argonone/compare/v0.0.13...v0.0.14) - 2024-04-07

### Other

- Update Dockerfile ([c1847f7](https://github.com/wielorzeczownik/docker-argonone/commit/c1847f7a82ed06d2c5bbbd16b0005fed1dc83077))

## [0.0.13](https://github.com/wielorzeczownik/docker-argonone/compare/v0.0.12...v0.0.13) - 2024-04-03

### Other

- 🔀 Merge pull request #14 from wielorzeczownik/develop ([1c44d20](https://github.com/wielorzeczownik/docker-argonone/commit/1c44d2049f4a1844a32f05bbcfafdc2ea86ff855))
- 🔀 Merge pull request #13 from wielorzeczownik/master ([0836f68](https://github.com/wielorzeczownik/docker-argonone/commit/0836f682c4a76e941f7f162a1228e2dad750126b))
- ⚰️  Remove renovate.json configuration file. ([68b5299](https://github.com/wielorzeczownik/docker-argonone/commit/68b529968dd99377ceff9dc4dafb844c229fbdc0))
- ⬆️ Bump ubuntu from 22.04 to 24.04 ([05c78c5](https://github.com/wielorzeczownik/docker-argonone/commit/05c78c56496a0b64436024ff70d4e59263b07cb2))
- Update renovate.json ([e25ba8d](https://github.com/wielorzeczownik/docker-argonone/commit/e25ba8d940d2f9eea6a09c30634f53b08c5dc450))
- Update renovate.json ([759b58a](https://github.com/wielorzeczownik/docker-argonone/commit/759b58a5e589afcea44e56d7ace2334933a806a0))
- Update renovate.json ([49ef58a](https://github.com/wielorzeczownik/docker-argonone/commit/49ef58abea252d91d3f4d9baacc8b4f6d426bd59))
- Update renovate.json ([a28f58c](https://github.com/wielorzeczownik/docker-argonone/commit/a28f58c677432c61b1024543e724df03378079e0))
- Update renovate.json ([96cf6ae](https://github.com/wielorzeczownik/docker-argonone/commit/96cf6ae55d2ac629340982b02617c753aaeef432))
- Update renovate.json ([f743592](https://github.com/wielorzeczownik/docker-argonone/commit/f743592cf5ecadd8638bcfaf1760c971d5414884))
- Update renovate.json ([db057fd](https://github.com/wielorzeczownik/docker-argonone/commit/db057fd78597f1f7de1237e8eb145b35c64bfed1))
- Update renovate.json ([f8327e9](https://github.com/wielorzeczownik/docker-argonone/commit/f8327e93f6dd2e576ca623f54d1813f8c2a036b1))
- Update renovate.json ([94e1791](https://github.com/wielorzeczownik/docker-argonone/commit/94e1791d8d48b8a51e2843f268fb482c07dede9d))
- Update renovate.json ([b692118](https://github.com/wielorzeczownik/docker-argonone/commit/b6921187bcd5579b4775462717b00cdea9daec6b))
- 🔀 Merge pull request #10 from wielorzeczownik/renovate/configure ([a1c6783](https://github.com/wielorzeczownik/docker-argonone/commit/a1c678375de714b2c0b36e17330ffb1e1f2cb615))
- Add renovate.json ([e29a462](https://github.com/wielorzeczownik/docker-argonone/commit/e29a4623beaa634d25db74b9bfde5735aec50099))

## [0.0.12](https://github.com/wielorzeczownik/docker-argonone/compare/v0.0.1...v0.0.12) - 2023-09-25

### Other

- :twisted_rightwards_arrows: Merge pull request #9 from wielorzeczownik/develop ([7cf9bf3](https://github.com/wielorzeczownik/docker-argonone/commit/7cf9bf39dcad583b0194b93fb0a8ebfe28daaa4b))
- :green_heart: Improved support for Docker images in GitHub Container Registry. ([f489e7c](https://github.com/wielorzeczownik/docker-argonone/commit/f489e7c1395cee060e8a006cf0ec39b14bdac687))
- :twisted_rightwards_arrows: Merge pull request #7 from wielorzeczownik/dependabot/docker/ubuntu-22.04 ([c878eef](https://github.com/wielorzeczownik/docker-argonone/commit/c878eef9418f0736e3759b7af54bef4b063de79d))
- :arrow_up: Bump ubuntu from 20.04 to 22.04 ([07e7034](https://github.com/wielorzeczownik/docker-argonone/commit/07e70346ec7cd8bb467793a42645364333b04e23))

## [0.0.1] - 2023-09-24

### Other

- 🔀 Merge pull request #6 from wielorzeczownik/develop ([24fc96f](https://github.com/wielorzeczownik/docker-argonone/commit/24fc96fb8c258957b57f4886f7803f2b6eedeacc))
- :memo: Update the README.md file. ([6192a0a](https://github.com/wielorzeczownik/docker-argonone/commit/6192a0a4672469a788d35fa365251edf09e16cfb))
- :green_heart: Fix workflows building docker image. ([ad52a6a](https://github.com/wielorzeczownik/docker-argonone/commit/ad52a6a1b520ff26ca823b888403fb52539db54f))
- :construction_worker: Update workflows building docker image. ([f73bd16](https://github.com/wielorzeczownik/docker-argonone/commit/f73bd16b6e461d9bf9e02ccf1323d966cb2d1aca))
- :memo: Update the README.md file. ([14948f1](https://github.com/wielorzeczownik/docker-argonone/commit/14948f11eb7a1af653d7f1c704011f42a62c1dc6))
- :memo: Update the README.md file. ([b4dfa16](https://github.com/wielorzeczownik/docker-argonone/commit/b4dfa1629ecfb0da58823b42c9c15f935dd9c2d5))
- :page_facing_up: License upgrade. ([08b5481](https://github.com/wielorzeczownik/docker-argonone/commit/08b548139afffcba20c6cd0db10c2fc414ba0313))
- :zap: Updated Dockerfile to Improve Image Build Speed ([176492a](https://github.com/wielorzeczownik/docker-argonone/commit/176492a4691a9707b274cdf205d82ec8c4390b44))
- :zap: Updated Dockerfile to Improve Image Build Speed ([9282f12](https://github.com/wielorzeczownik/docker-argonone/commit/9282f120504783c531f6ac13604e7d23534853c6))
- :arrow_up: Bump docker/build-push-action from 3 to 5 ([43d5f6b](https://github.com/wielorzeczownik/docker-argonone/commit/43d5f6bf3305686b11f8bf18824deb8ff095d8b1))
- :arrow_up: Bump docker/setup-buildx-action from 2 to 3 ([2ba15b8](https://github.com/wielorzeczownik/docker-argonone/commit/2ba15b8774c70890a975951ebdb3752e1e934fca))
- :arrow_up: Bump docker/login-action from 2 to 3 ([91cc401](https://github.com/wielorzeczownik/docker-argonone/commit/91cc4019efce6a600c59d05796f714f320f22e85))
- :arrow_up: Bump docker/setup-qemu-action from 2 to 3 ([d380ea9](https://github.com/wielorzeczownik/docker-argonone/commit/d380ea957d8eb3396f487856185747dfb436480e))
- :arrow_up: Bump actions/checkout from 3 to 4 ([850d08b](https://github.com/wielorzeczownik/docker-argonone/commit/850d08bd0d0deb45d3498f4ef56d4e86d800ad71))
- 👷 Update github workflow. ([d4b581f](https://github.com/wielorzeczownik/docker-argonone/commit/d4b581f593042b992bf80a2d651c4c4b5a7dc6f8))
- 👷 Create dependabot.yml ([6aa0fde](https://github.com/wielorzeczownik/docker-argonone/commit/6aa0fdef85020b0a0a160c819b39f0b5481cd284))
- 👷 Add dependabot.yml ([51b061f](https://github.com/wielorzeczownik/docker-argonone/commit/51b061fc40216690509c7e5af3f75e274f75c2ed))
- :construction_worker: Update github workflow. ([ee9ade1](https://github.com/wielorzeczownik/docker-argonone/commit/ee9ade1b33ca377c7006dd809e0ff50d65286a95))
- :construction_worker: Update github workflow. ([7825ee0](https://github.com/wielorzeczownik/docker-argonone/commit/7825ee07325dfc237a82b34bd5bbabbdd983d118))
- :construction_worker: Update github workflow. ([c01b9b2](https://github.com/wielorzeczownik/docker-argonone/commit/c01b9b2e1420e9466715455f1639dd4659551120))
- :recycle: Code refactoring and other smaller fixes. ([73809eb](https://github.com/wielorzeczownik/docker-argonone/commit/73809eb73532bd586d384b379e3ca28ba55137a7))
- Update Dockerfile ([9d2cbfc](https://github.com/wielorzeczownik/docker-argonone/commit/9d2cbfc002c5f06d3fae7ef05087cb1a1e731895))
- Create README.md ([7788930](https://github.com/wielorzeczownik/docker-argonone/commit/778893016f3e86afa9c077bfaa844f8c5fb4cdd6))
- Create docker-image.yml ([d6f2892](https://github.com/wielorzeczownik/docker-argonone/commit/d6f2892ef085fc3356e7cbbde9848eb314b46c03))
- Initial commit. ([410868b](https://github.com/wielorzeczownik/docker-argonone/commit/410868baa606e19424429d0086c1aa14e484e21b))

