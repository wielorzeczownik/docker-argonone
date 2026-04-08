#!/usr/bin/env python3

import hashlib
import sys
import urllib.request
from pathlib import Path

UPSTREAM = {
    "argon1.sh": "https://download.argon40.com/argon1.sh",
    "argononed.py": "https://download.argon40.com/scripts/argononed.py",
    "argonone-fanconfig.sh": "https://download.argon40.com/scripts/argonone-fanconfig.sh",
}

hashfile = Path(__file__).parent.parent / "patches" / "upstream.sha256"
expected = {
    name: digest
    for digest, name in (
        line.split() for line in hashfile.read_text().splitlines() if line
    )
}

failed = False

for name, url in UPSTREAM.items():
    with urllib.request.urlopen(url) as response:
        sha = hashlib.sha256()
        while buf := response.read(65536):
            sha.update(buf)
        actual = sha.hexdigest()
    if actual != expected[name]:
        print(
            f"::error::Upstream {name} changed (expected {expected[name]}, got {actual}). Review the diff and update patches/ and patches/upstream.sha256."
        )
        failed = True
    else:
        print(f"{name} hash matches.")

sys.exit(1 if failed else 0)
