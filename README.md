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

Dockerized Argon ONE fan-control and power-button driver for Raspberry Pi 4 and Raspberry Pi 5 — runs on any Linux distribution, no Raspberry Pi OS required.

> Based on the work of [johnmerchant](https://github.com/johnmerchant/docker-argonone) with two patches included:
>
> - `argononed.py` — daemon respects low PWM duty cycles (<25%) without a forced 100% spin-up,
> - `argonone-fanconfig.sh` — fan config accepts 0–100% duty cycle (no 30% floor).

## Run

The container runs systemd and requires `--privileged` to access hardware registers. Pass `/dev/i2c-1` so the daemon can reach the Argon ONE MCU over I2C.

### Docker Compose

```yaml
services:
  argonone:
    image: wielorzeczownik/argonone:latest
    container_name: argonone
    privileged: true
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
  --privileged \
  --restart unless-stopped \
  --device /dev/i2c-1:/dev/i2c-1 \
  --device /dev/gpiochip0:/dev/gpiochip0 \
  -v $(pwd)/argononed.conf:/etc/argononed.conf:ro \
  wielorzeczownik/argonone:latest
```

## Raspberry Pi 5

Raspberry Pi 5 moves the user-facing GPIO lines to the RP1 I/O chip, exposed as `/dev/gpiochip4` instead of `/dev/gpiochip0` used on earlier models. Add one extra device entry — everything else stays the same.

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
  --privileged \
  --restart unless-stopped \
  --device /dev/i2c-1:/dev/i2c-1 \
  --device /dev/gpiochip4:/dev/gpiochip4 \
  -v $(pwd)/argononed.conf:/etc/argononed.conf:ro \
  wielorzeczownik/argonone:latest
```

The same image works for both RPi 4 and RPi 5 — the Argon ONE installer auto-detects the board model from `/proc/cpuinfo`, which is passed through from the host in Docker.

## Fan configuration

`/etc/argononed.conf` maps temperature thresholds (°C) to fan speed percentages. Default template:

```
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
# Apply changes with:
# sudo systemctl restart argononed.service
#
55=10
60=55
65=100
```

Mount the file read-only (`:ro`) to avoid accidental edits inside the container. Values of `0` are honored (fan fully off) — no 30% floor is enforced.

## Host requirements

Enable I2C on the host before starting the container:

- Add `dtparam=i2c_arm=on` to `/boot/firmware/config.txt` (RPi 5) or `/boot/config.txt` (RPi 4)
- Load the kernel module: `modprobe i2c-dev`
- Optionally persist it: add `i2c-dev` to `/etc/modules-load.d/i2c.conf`

On Raspberry Pi 5, GPIO access goes through `libgpiod` and `/dev/gpiochip4`.
