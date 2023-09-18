<h1 align="center">
  Docker Argon One
</h1>

<p align="center">
  <picture>
    <source srcset="https://img.shields.io/badge/-RaspberryPi-C51A4A?style=flat-square&logo=Raspberry-Pi">
    <img
      src="https://img.shields.io/badge/-RaspberryPi-C51A4A?style=flat-square&logo=Raspberry-Pi"
      alt="Raspberry Pi"
    />
  </picture>
  <a href="https://hub.docker.com/r/wielorzeczownik/argonone">
    <picture>
      <source srcset="https://img.shields.io/badge/docker-%230db7ed.svg?style=flat-square&logo=docker&logoColor=white">
      <img
        src="https://img.shields.io/badge/docker-%230db7ed.svg?style=flat-square&logo=docker&logoColor=white"
        alt="Docker"
      />
    </picture>
  </a>
  <a href="https://gitmoji.dev">
    <picture>
      <source srcset="https://img.shields.io/badge/gitmoji-%20😜%20😍-FFDD67.svg?style=flat-square">
      <img
        src="https://img.shields.io/badge/gitmoji-%20😜%20😍-FFDD67.svg?style=flat-square"
        alt="Gitmoji"
      />
    </picture>
  </a>
  <a href="https://raw.githubusercontent.com/wielorzeczownik/docker-argonone/develop/LICENSE">
    <picture>
      <source srcset="https://img.shields.io/badge/license-BEERWARE%20%F0%9F%8D%BA-green?style=flat-square">
      <img
        src="https://img.shields.io/badge/license-BEERWARE%20%F0%9F%8D%BA-green?style=flat-square"
        alt="License"
      />
    </picture>
  </a>
  <a href="https://github.com/wielorzeczownik/docker-argonone/issues">
    <picture>
      <source srcset="https://img.shields.io/github/issues/wielorzeczownik/docker-argonone?style=flat-square">
      <img
        src="https://img.shields.io/github/issues/wielorzeczownik/docker-argonone?style=flat-square"
        alt="Issues"
      />
    </picture>
  </a>
  <a href="https://hub.docker.com/r/wielorzeczownik/argonone">
    <picture>
      <source srcset="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square">
      <img
        src="https://img.shields.io/docker/pulls/wielorzeczownik/argonone?style=flat-square"
        alt="Pulls"
      />
    </picture>
  </a>
</p>

<p align="center">
  Dockerized Driver for Argon ONE 🐳
</p>

Useful when you're running an operating system other than Raspberry Pi OS.

> This Docker image is based on the work of [jmercha](https://github.com/jmercha/docker-argonone).

## 🚀 Quick Start

To get a local copy up and running follow these simple steps.

### Using Docker Compose

1. Create `docker-compose.yml` as follows:

```yaml
version: "3.9"

services:
  argonone:
    cap_add:
      - SYS_RAWIO
    container_name: argonone
    devices:
      - /dev/gpiomem:/dev/gpiomem
    image: wielorzeczownik/argonone:latest
    privileged: true
    restart: unless-stopped
```

2. Run `docker compose` to start Argon ONE.

```sh
   docker compose up -d
```

3. You're all set! :godmode:

### Using Docker Run

1. Run the following command:

```bash
   docker run -d \
    --name argonone \
    --privileged \
    --restart unless-stopped \
    --cap-add SYS_RAWIO \
    --device /dev/gpiomem:/dev/gpiomem \
    wielorzeczownik/argonone:latest
```

2.  You're all set! :finnadie:

## ⚙️ Configuration

**To configure Argon ONE, add another volume mounted to `/etc/argononed.conf` as shown below:**

```yaml
  version: "3.9"

  services:
    argonone:
      cap_add:
        - SYS_RAWIO
      container_name: argonone
      devices:
        - /dev/gpiomem:/dev/gpiomem
      image: wielorzeczownik/argonone:latest
      privileged: true
      restart: unless-stopped
      volumes:
        - {your_cool_file}.conf:/etc/argononed.conf
```

**or**

```bash
  docker run -d \
    --name argonone \
    --privileged \
    --restart unless-stopped \
    --cap-add SYS_RAWIO \
    --device /dev/gpiomem:/dev/gpiomem \
    -v {your_cool_file}.conf:/etc/argononed.conf \
    wielorzeczownik/argonone:latest
```

### Default Configuration File Pattern

```bash
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
  # Above example sets the fan speed to
  #
  # NOTE: Lines begining with # are ignored
  #
  # Type the following at the command line for changes to take effect:
  # sudo systemctl restart argononed.service
  #
  # Start below:
  55=10
  60=55
  65=100
```

## 📧 Need Help or Have Questions?

If you encounter any issues, feel free to send me a private message or open an issue [here](https://github.com/wielorzeczownik/docker-argonone/issues).
