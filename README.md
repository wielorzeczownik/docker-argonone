<h1 align="center">
  Docker Argon One
</h1>

<p align="center">
  <a href="https://github.com/wielorzeczownik/docker-argonone/actions/workflows/release.yml"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/github/actions/workflow/status/wielorzeczownik/docker-argonone/release.yml?branch=master&style=flat-square&labelColor=2d333b&color=3fb950"/><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/github/actions/workflow/status/wielorzeczownik/docker-argonone/release.yml?branch=master&style=flat-square&color=2ea043"/><img src="https://img.shields.io/github/actions/workflow/status/wielorzeczownik/docker-argonone/release.yml?branch=master&style=flat-square&labelColor=2d333b&color=3fb950" alt="release"/></picture></a>
  <a href="https://github.com/wielorzeczownik/docker-argonone/releases/latest"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/github/v/release/wielorzeczownik/docker-argonone?style=flat-square&labelColor=2d333b&color=3fb950"/><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/github/v/release/wielorzeczownik/docker-argonone?style=flat-square&color=2ea043"/><img src="https://img.shields.io/github/v/release/wielorzeczownik/docker-argonone?style=flat-square&labelColor=2d333b&color=3fb950" alt="Latest Release"/></picture></a>
  <a href="https://hub.docker.com/r/wielorzeczownik/argonone"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square&labelColor=2d333b&color=3fb950"/><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square&color=2ea043"/><img src="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square&labelColor=2d333b&color=3fb950" alt="Pulls"/></picture></a>
  <a href="https://github.com/wielorzeczownik/docker-argonone/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/badge/License-MIT-3fb950?style=flat-square&labelColor=2d333b"/><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/badge/License-MIT-2ea043?style=flat-square"/><img src="https://img.shields.io/badge/License-MIT-3fb950?style=flat-square&labelColor=2d333b" alt="License: MIT"/></picture></a>
  <br/>
  <img src="https://img.shields.io/badge/-RaspberryPi-C51A4A?style=flat-square&logo=Raspberry-Pi" alt="Raspberry Pi"/>
  <a href="https://hub.docker.com/r/wielorzeczownik/argonone"><img src="https://img.shields.io/badge/docker-2496ed.svg?style=flat-square&logo=docker&logoColor=white" alt="Docker"/></a>
</p>

<p align="center">
  Dockerized Argon ONE driver for non‑Raspberry Pi OS distributions.
</p>

> Based on the work of [johnmerchant](https://github.com/johnmerchant/docker-argonone) with two patches included:
>
> -   `patches/argononed.py`: daemon respects low PWM duty cycles (<25%) without forced 100% spin-up,
> -   `patches/argonone-fanconfig.sh`: fan config accepts 0-100% duty cycle (no 30% floor).

## Run

The image uses systemd and must run privileged. To give the daemon access to sensors and I2C, pass the device nodes `/dev/i2c-1` (adjust if your board uses different paths).

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
        volumes:
            - ./argononed.conf:/etc/argononed.conf:ro
```

```sh
docker compose up -d
```

You're all set! :godmode:

### Docker Run

```bash
docker run -d \
  --name argonone \
  --privileged \
  --restart unless-stopped \
  --device /dev/i2c-1:/dev/i2c-1 \
  -v $(pwd)/argononed.conf:/etc/argononed.conf:ro \
  wielorzeczownik/argonone:latest
```

You're all set! :finnadie:

## Fan configuration

`/etc/argononed.conf` defines temperature thresholds and fan speeds (percent). Default template:

```
#
# Argon One Fan Configuration
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

Adjust the values to your needs and mount the file read-only (`:ro`) to avoid accidental edits inside the container.

## Host requirements

Ensure I2C is enabled on the host:

-   add `dtparam=i2c_arm=on` to `/boot/config.txt` or `/boot/usercfg.txt`,
-   load the `i2c-dev` module (`modprobe i2c-dev`) and optionally persist it in `/etc/modules-load.d/i2c.conf`,
-   expose `/dev/gpiomem` if your board uses it.
