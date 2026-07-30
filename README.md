<h1 align="center">docker-argonone</h1>

<p align="center">
  <a href="https://github.com/wielorzeczownik/docker-argonone/actions/workflows/release.yml"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/github/actions/workflow/status/wielorzeczownik/docker-argonone/release.yml?branch=master&style=flat-square&labelColor=2d333b&color=3fb950"/><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/github/actions/workflow/status/wielorzeczownik/docker-argonone/release.yml?branch=master&style=flat-square&color=2ea043"/><img src="https://img.shields.io/github/actions/workflow/status/wielorzeczownik/docker-argonone/release.yml?branch=master&style=flat-square&labelColor=2d333b&color=3fb950" alt="release"/></picture></a> <a href="https://github.com/wielorzeczownik/docker-argonone/releases/latest"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/github/v/release/wielorzeczownik/docker-argonone?style=flat-square&labelColor=2d333b&color=3fb950"/><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/github/v/release/wielorzeczownik/docker-argonone?style=flat-square&color=2ea043"/><img src="https://img.shields.io/github/v/release/wielorzeczownik/docker-argonone?style=flat-square&labelColor=2d333b&color=3fb950" alt="Latest Release"/></picture></a> <a href="https://hub.docker.com/r/wielorzeczownik/argonone"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square&labelColor=2d333b&color=3fb950"/><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square&color=2ea043"/><img src="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square&labelColor=2d333b&color=3fb950" alt="Docker Pulls"/></picture></a> <a href="https://github.com/wielorzeczownik/docker-argonone/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/badge/License-MIT-3fb950?style=flat-square&labelColor=2d333b"/><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/badge/License-MIT-2ea043?style=flat-square"/><img src="https://img.shields.io/badge/License-MIT-3fb950?style=flat-square&labelColor=2d333b" alt="License: MIT"/></picture></a>
  <br/>
  <img src="https://img.shields.io/badge/-RaspberryPi-C51A4A?style=flat-square&logo=Raspberry-Pi" alt="Raspberry Pi"/>
  <a href="https://hub.docker.com/r/wielorzeczownik/argonone"><img src="https://img.shields.io/badge/docker-2496ed.svg?style=flat-square&logo=docker&logoColor=white" alt="Docker"/></a>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/wielorzeczownik/docker-argonone/master/assets/logo.png" alt="Dockerized Argon ONE logo" width="520" />
</p>

Dockerized Argon ONE fan-control and power-button driver for Raspberry Pi 4 and Raspberry Pi 5 – runs on any Linux distribution, no Raspberry Pi OS required.

> Based on the work of [johnmerchant](https://github.com/johnmerchant/docker-argonone) with patches included:
>
> - `argononed.py` – daemon respects low PWM duty cycles (<25%) without a forced 100% spin-up; logs CPU temperature and fan speed to `docker logs`,
> - `argonone-fanconfig.sh` – fan config accepts 0-100% duty cycle (no 30% floor).

## Variants

Two images are published from the same daemon and patches. Pick based on whether you need the power button.

| Variant                | Docker image                       | Container access        | Power button             |
| ---------------------- | ---------------------------------- | ----------------------- | ------------------------ |
| **Standard** (default) | `wielorzeczownik/argonone:latest`  | `--device` (I2C + GPIO) | ❌ fan control only      |
| **systemd**            | `wielorzeczownik/argonone:systemd` | `--privileged`          | ✅ shutdown/reboot works |

Fan control is identical in both. The **Standard** image runs the daemon directly as PID 1 and only needs the two device nodes. The **systemd** image runs systemd as PID 1 so the Argon ONE power button can trigger an OS shutdown/reboot, at the cost of requiring `--privileged`.

> [!WARNING]
> The systemd variant runs with `--privileged`, granting the container broad host access. Use the Standard image unless you specifically need power-button shutdown.

## Run

Pass `/dev/i2c-1` so the daemon can reach the Argon ONE MCU over I2C, and `/dev/gpiochip0` for power button GPIO.

### Docker Compose

```yaml
services:
  argonone:
    image: wielorzeczownik/argonone:latest
    container_name: argonone
    restart: unless-stopped
    devices:
      - /dev/i2c-1:/dev/i2c-1
      - /dev/gpiochip0:/dev/gpiochip0
    volumes:
      - ./argononed.conf:/etc/argononed.conf:ro
```

```sh
docker compose up -d
```

### Docker Run

```bash
docker run -d \
  --name argonone \
  --restart unless-stopped \
  --device /dev/i2c-1:/dev/i2c-1 \
  --device /dev/gpiochip0:/dev/gpiochip0 \
  -v $(pwd)/argononed.conf:/etc/argononed.conf:ro \
  wielorzeczownik/argonone:latest
```

## Raspberry Pi 5

Raspberry Pi 5 moves the user-facing GPIO lines to the RP1 I/O chip, exposed as `/dev/gpiochip4` instead of `/dev/gpiochip0` used on earlier models. Add one extra device entry – everything else stays the same.

Docker Compose:

```yaml
devices:
  - /dev/i2c-1:/dev/i2c-1
  - /dev/gpiochip4:/dev/gpiochip4
```

Docker Run:

```bash
docker run -d \
  --name argonone \
  --restart unless-stopped \
  --device /dev/i2c-1:/dev/i2c-1 \
  --device /dev/gpiochip4:/dev/gpiochip4 \
  -v $(pwd)/argononed.conf:/etc/argononed.conf:ro \
  wielorzeczownik/argonone:latest
```

The same image works for both RPi 4 and RPi 5 – the Argon ONE installer auto-detects the board model from `/proc/cpuinfo`, which is passed through from the host in Docker.

## systemd variant (power button)

To use the power button for OS shutdown/reboot, run the `:systemd` image with `--privileged`. The device nodes and the Raspberry Pi 5 note above still apply – only the tag and `--privileged` change.

### Docker Compose (systemd)

```yaml
services:
  argonone:
    image: wielorzeczownik/argonone:systemd
    container_name: argonone
    restart: unless-stopped
    privileged: true
    devices:
      - /dev/i2c-1:/dev/i2c-1
      - /dev/gpiochip0:/dev/gpiochip0
    volumes:
      - ./argononed.conf:/etc/argononed.conf:ro
```

### Docker Run (systemd)

```bash
docker run -d \
  --name argonone \
  --restart unless-stopped \
  --privileged \
  --device /dev/i2c-1:/dev/i2c-1 \
  --device /dev/gpiochip0:/dev/gpiochip0 \
  -v $(pwd)/argononed.conf:/etc/argononed.conf:ro \
  wielorzeczownik/argonone:systemd
```

## Configuration

### Runtime inputs

| Input                 | Required             | Default              | Meaning                                                                      |
| --------------------- | -------------------- | -------------------- | ---------------------------------------------------------------------------- |
| `/dev/i2c-1`          | yes                  | –                    | I2C bus the Argon ONE MCU sits on. The daemon exits without it.              |
| `/dev/gpiochip0`      | for the power button | –                    | GPIO chip carrying the power-button line on Raspberry Pi 4 and earlier.      |
| `/dev/gpiochip4`      | for the power button | –                    | GPIO chip on Raspberry Pi 5, where the lines moved to the RP1 I/O chip.      |
| `/etc/argononed.conf` | no                   | 55=10, 60=55, 65=100 | Temperature-to-fan-speed map. Mount read-only; see the table below.          |
| `--privileged`        | systemd variant only | off                  | Required by the `:systemd` image so the power button can shut the host down. |

The image reads no environment variables. Everything it needs comes from the
device nodes and the mounted config file.

### Build arguments

Only relevant if you build the image yourself.

| Argument           | Required | Default                                  | Meaning                                                |
| ------------------ | -------- | ---------------------------------------- | ------------------------------------------------------ |
| `ARGON_SCRIPT_URL` | no       | `https://download.argon40.com/argon1.sh` | Upstream Argon ONE installer fetched during the build. |

## Fan configuration

`/etc/argononed.conf` maps temperature thresholds (°C) to fan speed percentages. Default template:

```ini
#
# Argon ONE Fan Configuration
#
# List below the temperature (Celsius) and fan speed (in percent) pairs
# Use the following form:
# min.temperature=speed
#
# Example:
# 55=10
# 60=55
# 65=100
#
# NOTE: Lines beginning with # are ignored
#
# Apply changes with: docker restart argonone
#
55=10
60=55
65=100
```

Mount the file read-only (`:ro`) to avoid accidental edits inside the container. Values of `0` are honored (fan fully off) – no 30% floor is enforced.

## Host requirements

Enable I2C on the host before starting the container:

- Add `dtparam=i2c_arm=on` to `/boot/firmware/config.txt` (RPi 5) or `/boot/config.txt` (RPi 4)
- Load the kernel module: `modprobe i2c-dev`
- Optionally persist it: add `i2c-dev` to `/etc/modules-load.d/i2c.conf`

On Raspberry Pi 5, GPIO access goes through `libgpiod` and `/dev/gpiochip4`.
