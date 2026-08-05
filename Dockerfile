FROM ubuntu:26.04@sha256:678c6550cc43645e08669028bc177f50be4e7c5b8cca677067b1914d4afc7a03

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

# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get install -y --no-install-recommends wget ca-certificates software-properties-common \
  && add-apt-repository -y universe \
  && apt-get update \
  && apt-get install -y --no-install-recommends python3-libgpiod python3-smbus \
  && rm -rf /var/lib/apt/lists/*

# Stubs so argon1.sh runs without systemd or sudo; install Argon ONE; purge build-time tools
RUN printf '#!/bin/sh\nexec "$@"\n' > /usr/local/bin/sudo \
  && printf '#!/bin/sh\nexit 0\n' > /usr/local/bin/systemctl \
  && chmod +x /usr/local/bin/sudo /usr/local/bin/systemctl \
  && wget -qO /tmp/argon1.sh "${ARGON_SCRIPT_URL}" \
  && chmod +x /tmp/argon1.sh \
  && /tmp/argon1.sh \
  && rm /tmp/argon1.sh \
  && apt-get purge -y wget software-properties-common \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chmod=755 patches/argononed.py /etc/argon/argononed.py
COPY --chmod=755 patches/argonone-fanconfig.sh /etc/argon/argonone-fanconfig.sh
COPY --chmod=755 healthcheck.py /usr/local/bin/healthcheck

HEALTHCHECK --interval=60s --timeout=5s --start-period=10s --retries=3 \
  CMD healthcheck

CMD ["/usr/bin/python3", "/etc/argon/argononed.py", "SERVICE"]
