# Patches

This directory contains modified versions of two upstream files. When upstream updates
(`scripts/check-upstream.py` fails), re-apply the changes described here to the new
upstream versions. Run `scripts/update-upstream.py` to fetch fresh copies, then diff
against these files to see what needs re-applying.

## `argononed.py`

Upstream source: `https://download.argon40.com/scripts/argononed.py`

### 1. Remove forced spin-up in `get_fanspeed()`

The original returns `0` for speeds below 1% but otherwise forces a 25 % floor – any
configured duty cycle lower than 25 is silently raised. The patch removes this floor and
returns the configured value as-is.

**Original:**

```python
if tempval >= tempcfg:
    if fancfg < 25:
        return 100  # spin up first, then drop to 25 %
    return fancfg
```

**Patched:**

```python
if tempval >= tempcfg:
    if fancfg < 1:
        return 0
    return fancfg
```

### 2. Remove forced 100 % spin-up in `temp_check()`

Before applying a new speed the original briefly forces the fan to 100 % to guarantee
it spins up. This makes low duty cycles (e.g. 5-20 %) impossible in practice.

**Original** (inside the `try` block in `temp_check`):

```python
argonregister_setfanspeed(bus, 100, argonregsupport)   # forced spin-up
argonregister_setfanspeed(bus, newspeed, argonregsupport)
```

**Patched:**

```python
argonregister_setfanspeed(bus, newspeed, argonregsupport)
```

### 3. Temperature logging (our addition, not upstream)

These lines have no upstream equivalent – they are added on top of the patched file.

- `import datetime` added to the top-level import block.
- In `temp_check()`, the CPU temperature variable is captured as `cpu_temp` (upstream
  uses a generic `val` that gets overwritten by the HDD temperature query).
- A `print()` call after `argonregister_setfanspeed` logs each fan-speed change with a
  timestamp, CPU temperature, and new fan percentage to stdout, which surfaces in
  `docker logs` thanks to `ForwardToConsole=yes` in journald.conf.

```python
# top-level imports
import datetime

# rename val → cpu_temp for CPU read
cpu_temp = argonsysinfo_getcputemp()
newspeed = get_fanspeed(cpu_temp, fanconfig)

# after argonregister_setfanspeed(...)
print(
    f"{datetime.datetime.now().isoformat(timespec='seconds')} | cpu: {cpu_temp:.1f}°C | fan: {newspeed}%",
    flush=True,
)
```

## `argonone-fanconfig.sh`

Upstream source: `https://download.argon40.com/scripts/argonone-fanconfig.sh`

### Remove 30 % floor in fan speed validation

The original rejects any fan speed below 30, making it impossible to configure quiet
low-speed profiles via the interactive tool. The patch widens the accepted range to 0-100
in all three input loops (always-on mode, preset-temperature mode, and custom-pair mode).

**Original** (appears three times, once per input loop):

```bash
if [ $curfan -ge 30 ] && [ $curfan -le 100 ]
```

**Patched** (same three locations, marked with `# PATCH: allow low duty cycles; accept 0-100`):

```bash
if [ $curfan -ge 0 ] && [ $curfan -le 100 ]
```
