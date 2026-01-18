<h1 align="center">
  Docker Argon One
</h1>

<p align="center">
  <picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/badge/-RaspberryPi-E25D6A?style=flat-square&logo=Raspberry-Pi&logoColor=white&labelColor=2d333b"><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/badge/-RaspberryPi-C51A4A?style=flat-square&logo=Raspberry-Pi"><img src="https://img.shields.io/badge/-RaspberryPi-C51A4A?style=flat-square&logo=Raspberry-Pi" alt="Raspberry Pi"/></picture>
  <a href="https://hub.docker.com/r/wielorzeczownik/argonone"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/badge/docker-2496ed.svg?style=flat-square&logo=docker&logoColor=white&labelColor=2d333b"><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/badge/docker-%230db7ed.svg?style=flat-square&logo=docker&logoColor=white"><img src="https://img.shields.io/badge/docker-%230db7ed.svg?style=flat-square&logo=docker&logoColor=white"alt="Docker"/></picture></a>
  <a href="https://github.com/wielorzeczownik/docker-argonone/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-2ea043?style=flat-square" alt="License: MIT"/></a>
  <a href="https://github.com/wielorzeczownik/docker-argonone/issues"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/github/issues/wielorzeczownik/docker-argonone?style=flat-square&labelColor=2d333b&color=3fb950"><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/github/issues/wielorzeczownik/docker-argonone?style=flat-square"><img src="https://img.shields.io/github/issues/wielorzeczownik/docker-argonone?style=flat-square" alt="Issues"/></picture></a>
  <a href="https://github.com/wielorzeczownik/docker-argonone/stargazers"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/github/stars/wielorzeczownik/docker-argonone?style=flat-square&labelColor=2d333b&color=ffa657"><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/github/stars/wielorzeczownik/docker-argonone?style=flat-square"><img src="https://img.shields.io/github/stars/wielorzeczownik/docker-argonone?style=flat-square" alt="Stars"/></picture></a>
  <a href="https://hub.docker.com/r/wielorzeczownik/argonone"><picture><source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square&labelColor=2d333b&color=539bf5"><source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square"><img src="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square" alt="Pulls"/></picture></a>
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
