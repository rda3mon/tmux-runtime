#!/usr/bin/env sh

mem_available=$(cat /proc/meminfo | grep MemAvailablee: | grep -o '[0-9]*')
mem_free=$(cat /proc/meminfo | grep MemFree: | grep -o '[0-9]*')
mem_inactive=$(cat /proc/meminfo | grep Inactive: | grep -o '[0-9]*')
mem_sreclaimable=$(cat /proc/meminfo | grep SReclaimable: | grep -o '[0-9]*')
mem_total=$(cat /proc/meminfo | grep MemTotal: | grep -o '[0-9]*')

if [ -z $mem_available ]; then
	mem_available=$(awk -v mem_free=$mem_free -v mem_inactive=$mem_inactive -v mem_sreclaimable=$mem_sreclaimable 'BEGIN { print (mem_free+mem_inactive+mem_sreclaimable) }')
fi

mem_percentage=$(awk -v mem_available=$mem_available -v mem_total=$mem_total 'BEGIN { print  ((mem_available/mem_total)*100) }')
echo "MEM: ${mem_percentage%??}"
