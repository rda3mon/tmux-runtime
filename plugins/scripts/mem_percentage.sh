#!/usr/bin/env sh

mem_available=$(cat /proc/meminfo | grep MemAvailable: | grep -o '[0-9]*')
mem_free=$(cat /proc/meminfo | grep MemFree: | grep -o '[0-9]*')
mem_inactive=$(cat /proc/meminfo | grep Inactive: | grep -o '[0-9]*')
mem_sreclaimable=$(cat /proc/meminfo | grep SReclaimable: | grep -o '[0-9]*')
mem_total=$(cat /proc/meminfo | grep MemTotal: | grep -o '[0-9]*')

if [ -z $mem_available ]; then
	mem_available=$(echo "$mem_free+$mem_inactive+$mem_sreclaimable" | bc)
fi

mem_percentage=$(echo "scale=4; ($mem_available/$mem_total)*100" | bc)
echo ${mem_percentage%??}
