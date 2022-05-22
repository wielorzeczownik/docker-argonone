# Docker Argon One
**Docker version of the driver for Argon ONE 🐳**

Helpful when you are using a system other than Raspberry Pi OS

<a href="https://github.com/manythingsatonce/docker-argonone/blob/master/LICENSE"><img alt="license" src="https://img.shields.io/badge/license-BEERWARE%20%F0%9F%8D%BA-green"></a> <a href="https://hub.docker.com/r/manythingsatonce/argonone"><img alt="release" src="https://img.shields.io/docker/pulls/manythingsatonce/argonone"></a> <a href="https://github.com/manythingsatonce/docker-argonone/issues"><img src="https://img.shields.io/github/issues/manythingsatonce/docker-argonone"></a>

>This docker image is modeled after the image created by [jmercha](https://github.com/jmercha/docker-argonone).

## Quick Start

To get a local copy up and running follow these simple steps.

### Docker Compose

1. Create `docker-compose.yml` as follows:

```yaml
version: "3"

services:
    argonone:
      container_name: argonone
      image: manythingsatonce/argonone:latest
      privileged: true
      volumes:
        - /proc/device-tree:/proc/device-tree
        - /proc/cpuinfo:/proc/cpuinfo
        - /sys/class/gpio:/sys/class/gpio
      restart: always
```

2. Run `docker compose` to build and start argonone.

```sh
   docker-compose up -d
```

3. Done :godmode:

### Docker Run

1. Run the command.

```sh
   docker run --name argonone manythingsatonce/argonone:latest --privileged -v '/proc/device-tree:/proc/device-tree' -v '/proc/cpuinfo:/proc/cpuinfo' -v '/sys/class/gpio:/sys/class/gpio' --restart always
```
 2. Done :finnadie:

## Configuration
**The best way to configure it is to add another volume assigned to `/etc/argononed.conf` as follows**

```yaml
  version: "3"

  services:
      argonone:
        container_name: argonone
        image: manythingsatonce/argonone:latest
        privileged: true
        volumes:
          - /proc/device-tree:/proc/device-tree
          - /proc/cpuinfo:/proc/cpuinfo
          - /sys/class/gpio:/sys/class/gpio
          - {your_cool_file}.conf:/etc/argononed.conf
        restart: always
```
**or**

 ```sh
   docker run --name argonone manythingsatonce/argonone:latest --privileged -v '/proc/device-tree:/proc/device-tree' -v '/proc/cpuinfo:/proc/cpuinfo' -v '/sys/class/gpio:/sys/class/gpio' -v '{your_cool_file}.conf:/etc/argononed.conf' --restart always
   ```
### Default configuration file pattern

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

## How to get in touch?

If you have a problem, write to me in a private message or open issue [here](https://github.com/manythingsatonce/docker-argonone/issues).
