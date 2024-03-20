#!/usr/bin/env python3
import os
import json

with open("/sys/class/power_supply/BAT0/status") as f:
    discharging = "Dis" in f.read().strip()

with open("/sys/class/power_supply/BAT0/capacity") as f:
    capacity = int(f.read().strip())

verbose = int(os.getenv("verbose") or 0)
warning = int(os.getenv("warning") or 1000)
if os.getenv("button") is not None:
    warning = capacity
flash = int(not int(os.getenv("flash") or 0))
if discharging:
    if capacity < 30:
        warning_active = abs(capacity - warning) > 10
        color = "#e75a7c" if flash and warning_active else "#dbb651"
        text = f"<span color=\"#252623\" bgcolor=\"{color}\"> <b>!!{capacity}%!!</b> </span>"
    else:
        text = f"<b>{capacity}</b>%"
else:
    warning = 1000
    text = f"<b>{capacity}</b>+"

print(json.dumps({ "flash": flash, "full_text": text, "warning": warning }))
