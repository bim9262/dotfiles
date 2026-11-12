#!/bin/python

import subprocess
import re

section_re = re.compile(r"^[a-zA-Z]+$")
sinks_re = re.compile(r"^ │  (\*)?\s*([0-9]+)\.")

section = None
in_sinks = False
default_sink = None

sinks = []


result = subprocess.run(["wpctl", "status"], stdout=subprocess.PIPE)
for line in result.stdout.decode().splitlines():
    if section_re.match(line):
        section = line
    elif section == "Audio" and line.startswith(" ├─ Sinks:"):
        in_sinks = True
    elif line.strip() == "│":
        in_sinks = False
    elif in_sinks:
        sinks_match = sinks_re.match(line)
        if sinks_match.group(1) is not None:
            default_sink = len(sinks)
        sinks.append(sinks_match.group(2))


subprocess.run(["wpctl", "set-default", sinks[(default_sink + 1) % len(sinks)]])
