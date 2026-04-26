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

These lines have no upstream equivalent — they are added on top of the patched file.

- `import datetime` added to the top-level import block.
- In `temp_check()`, the CPU temperature variable is captured as `cpu_temp` (upstream
  uses a generic `val` that gets overwritten by the HDD temperature query).
- A `print()` call at the top of the loop logs every 30 seconds with a timestamp, CPU
  temperature, and current fan percentage. Visible in `docker logs` because the daemon
  runs as PID 1 (stdout goes directly to Docker's log driver).

```python
# top-level imports
import datetime

# in temp_check() - rename val → cpu_temp for CPU read
cpu_temp = argonsysinfo_getcputemp()
newspeed = get_fanspeed(cpu_temp, fanconfig)

# top of the while loop, before the prevspeed == newspeed check
print(
    f"{datetime.datetime.now().isoformat(timespec='seconds')} | cpu: {cpu_temp:.1f}°C | fan: {newspeed}%",
    flush=True,
)
```

### 4. Reload config every cycle (our addition, not upstream)

`load_fancpuconfig()` and `load_fanhddconfig()` are moved inside the `while True` loop
so config changes take effect within the next 30-second cycle without restarting the
daemon. This makes `argonone-fanconfig.sh` work correctly even though its
`systemctl restart` call is a no-op in this container.

**Original** (before the loop):

```python
fanconfig = load_fancpuconfig()
fanhddconfig = load_fanhddconfig()

prevspeed = INITIALSPEEDVAL
while True:
    ...
```

**Patched** (inside the loop):

```python
prevspeed = INITIALSPEEDVAL
while True:
    fanconfig = load_fancpuconfig()
    fanhddconfig = load_fanhddconfig()
    ...
```

### 5. Fix process lifetime – `ipcq.join()` → `t2.join()` (our addition, not upstream)

`Queue.join()` returns immediately when the queue has no unfinished tasks (count starts
at zero). With no systemd supervisor restarting the process, this caused the daemon to
exit after a single loop iteration. Blocking on the temp_check thread instead keeps the
process alive as long as the daemon is running.

**Original:**

```python
ipcq.join()
```

**Patched:**

```python
t2.join()
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
