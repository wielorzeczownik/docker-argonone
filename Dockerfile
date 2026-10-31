FROM ubuntu:26.04@sha256:6a06111c3b0a8600feadb270aec771dc239bf407b25625f93f44ab00e11f4d3c

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

# Install deps, stub sudo/systemctl so argon1.sh runs without systemd, install Argon ONE,
# purge build-time tools and drop the unused Go-based pebble binary, all in one layer
# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get install -y --no-install-recommends wget ca-certificates python3-libgpiod python3-smbus \
  && rm -rf /var/lib/apt/lists/* \
  && printf '#!/bin/sh\nexec "$@"\n' > /usr/local/bin/sudo \
  && printf '#!/bin/sh\nexit 0\n' > /usr/local/bin/systemctl \
  && chmod +x /usr/local/bin/sudo /usr/local/bin/systemctl \
  && wget -qO /tmp/argon1.sh "${ARGON_SCRIPT_URL}" \
  && chmod +x /tmp/argon1.sh \
  && /tmp/argon1.sh \
  && apt-get purge -y wget \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /usr/bin/pebble /var/lib/pebble /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chmod=755 patches/argononed.py /etc/argon/argononed.py
COPY --chmod=755 patches/argonone-fanconfig.sh /etc/argon/argonone-fanconfig.sh
COPY --chmod=755 healthcheck.py /usr/local/bin/healthcheck

HEALTHCHECK --interval=60s --timeout=5s --start-period=10s --retries=3 \
  CMD ["healthcheck"]

CMD ["/usr/bin/python3", "/etc/argon/argononed.py", "SERVICE"]
