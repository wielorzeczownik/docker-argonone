FROM ubuntu:24.04@sha256:186072bba1b2f436cbb91ef2567abca677337cfc786c86e107d25b7072feef0c

ARG ARGON_SCRIPT_URL=https://download.argon40.com/argon1.sh

LABEL org.opencontainers.image.source="https://github.com/wielorzeczownik/ahe-ics" \
  maintainer="wielorzeczownik <wielorzeczownik@furryunicorn.com>" \
  org.opencontainers.image.description="Dockerized Argon ONE fan-control and power-button driver for non‑Raspberry Pi OS distributions"

ENV DEBIAN_FRONTEND=noninteractive

# Base tools for the Argon installer and daemon
# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get install -y --no-install-recommends sudo systemd wget curl ca-certificates software-properties-common \
  && add-apt-repository -y universe \
  && apt-get update \
  && apt-get install -y --no-install-recommends python3-libgpiod python3-smbus \
  && rm -rf /var/lib/apt/lists/*

# Remove timers that break in containerized systemd and set default target
# hadolint ignore=DL4006
RUN find /etc/systemd -name '*.timer' -print0 | xargs -0 rm -v || true && \
  systemctl set-default multi-user.target

# Download and install Argon ONE from upstream script
RUN curl -fsSL "${ARGON_SCRIPT_URL}" -o /tmp/argon1.sh \
  && chmod +x /tmp/argon1.sh \
  && /tmp/argon1.sh \
  && rm /tmp/argon1.sh \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Patch daemon and config tool to respect low fan duty cycles without forced spin-up / 30% floor
COPY patches/argononed.py /etc/argon/argononed.py
COPY patches/argonone-fanconfig.sh /etc/argon/argonone-fanconfig.sh
RUN chmod 755 /etc/argon/argononed.py /etc/argon/argonone-fanconfig.sh \
  && systemctl enable argononed

CMD ["/lib/systemd/systemd"]
