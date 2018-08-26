#!/usr/bin/env bash

ppid=$1

pid=$(ps --no-headers --ppid $ppid -o pid)
current_pid=$$

pid="${pid[@]/$current_pid}"

if [ -z $pid ]; then
	echo ""
else
	echo "| CMD:$(ps --no-headers --ppid $ppid -o pid) | CPU:$(ps --no-headers --ppid $ppid -o %cpu) | Mem:$(ps --no-headers --ppid $ppid -o %mem) | CMD:$(ps --no-headers --ppid $ppid -o command) "
fi
