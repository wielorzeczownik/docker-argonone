#!/usr/bin/env python3
import sys

try:
    with open("/sys/class/thermal/thermal_zone0/temp") as f:
        t = int(f.read()) / 1000
    with open("/dev/i2c-1"):
        pass
    print(f"cpu: {t:.1f}C")
except Exception as e:
    print(f"unhealthy: {e}", file=sys.stderr)
    sys.exit(1)
