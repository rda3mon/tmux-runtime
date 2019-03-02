#!/usr/bin/env bash

echo "TOP: $(ps --no-headers -A -o %cpu:3,%mem:3,comm --sort=-%cpu,-%mem | head -1)"
