#!/usr/bin/env bash

echo "Load: $(cat /proc/loadavg  |  grep -oE '^[0-9.]{4} [0-9.]{4} [0-9.]{4}')"
