#!/usr/bin/env bash

echo "Load: $(cat /proc/loadavg  | sed 's/ \w*$//')"
