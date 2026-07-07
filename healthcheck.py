#!/usr/bin/env python3
# ruff: noqa: T201  # container healthcheck: prints status to stdout
import sys
from pathlib import Path

try:
    thermal = Path("/sys/class/thermal/thermal_zone0/temp")
    temp = int(thermal.read_text()) / 1000
    with Path("/dev/i2c-1").open():
        pass
    print(f"cpu: {temp:.1f}C")
except (OSError, ValueError) as exc:
    print(f"unhealthy: {exc}", file=sys.stderr)
    sys.exit(1)
