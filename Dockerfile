FROM ubuntu:resolute-20260413@sha256:5e275723f82c67e387ba9e3c24baa0abdcb268917f276a0561c97bef9450d0b4

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
