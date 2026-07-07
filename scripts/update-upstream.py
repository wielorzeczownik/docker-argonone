#!/usr/bin/env python3
# ruff: noqa: S310, T201  # CI helper: fetches pinned upstream URLs, prints to stdout

import hashlib
import urllib.request
from pathlib import Path

UPSTREAM = {
    "argon1.sh": "https://download.argon40.com/argon1.sh",
    "argononed.py": "https://download.argon40.com/scripts/argononed.py",
    "argonone-fanconfig.sh": "https://download.argon40.com/scripts/argonone-fanconfig.sh",
}

hashfile = Path(__file__).parent.parent / "patches" / "upstream.sha256"

lines = []
for name, url in UPSTREAM.items():
    with urllib.request.urlopen(url) as response:
        sha = hashlib.sha256()
        while buf := response.read(65536):
            sha.update(buf)
        digest = sha.hexdigest()
    lines.append(f"{digest}  {name}")
    print(f"Updated {name}: {digest}")

hashfile.write_text("\n".join(lines) + "\n")
print(f"\nSaved to {hashfile}")
