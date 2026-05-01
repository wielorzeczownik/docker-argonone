FROM ubuntu:resolute-20260413@sha256:5e275723f82c67e387ba9e3c24baa0abdcb268917f276a0561c97bef9450d0b4

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG ARGON_SCRIPT_URL=https://download.argon40.com/argon1.sh

LABEL org.opencontainers.image.source="https://github.com/wielorzeczownik/docker-argonone" \
  org.opencontainers.image.url="https://github.com/wielorzeczownik/docker-argonone" \
  org.opencontainers.image.documentation="https://github.com/wielorzeczownik/docker-argonone#readme" \
  org.opencontainers.image.title="docker-argonone" \
  org.opencontainers.image.description="Dockerized Argon ONE fan-control and power-button driver for non‑Raspberry Pi OS distributions" \
  org.opencontainers.image.authors="wielorzeczownik" \
  org.opencontainers.image.vendor="wielorzeczownik"

ENV DEBIAN_FRONTEND=noninteractive

# Base tools for the Argon installer and daemon
# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get install -y --no-install-recommends wget ca-certificates software-properties-common \
  && add-apt-repository -y universe \
  && apt-get update \
  && apt-get install -y --no-install-recommends python3-libgpiod python3-smbus \
  && rm -rf /var/lib/apt/lists/*

# Stubs so argon1.sh installer runs without systemd or sudo in the image.
# sudo: pass-through (we are already root); systemctl: no-op (daemon runs directly).
RUN printf '#!/bin/sh\nexec "$@"\n' > /usr/local/bin/sudo && \
  printf '#!/bin/sh\nexit 0\n'   > /usr/local/bin/systemctl && \
  chmod +x /usr/local/bin/sudo /usr/local/bin/systemctl

# Download and install Argon ONE from upstream script
RUN wget -qO /tmp/argon1.sh "${ARGON_SCRIPT_URL}" \
  && chmod +x /tmp/argon1.sh \
  && /tmp/argon1.sh \
  && rm /tmp/argon1.sh \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Patch daemon and config tool to respect low fan duty cycles without forced spin-up / 30% floor
COPY patches/argononed.py /etc/argon/argononed.py
COPY patches/argonone-fanconfig.sh /etc/argon/argonone-fanconfig.sh
RUN chmod 755 /etc/argon/argononed.py /etc/argon/argonone-fanconfig.sh

HEALTHCHECK --interval=60s --timeout=5s --start-period=10s --retries=3 \
  CMD python3 -c "\
  t = int(open('/sys/class/thermal/thermal_zone0/temp').read()) / 1000; \
  open('/dev/i2c-1'); \
  print(f'cpu: {t:.1f}C')"

CMD ["/usr/bin/python3", "/etc/argon/argononed.py", "SERVICE"]
