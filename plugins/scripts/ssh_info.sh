#!/usr/bin/env bash

ppid=$1
cmd=$2
re='^[0-9]+$'

if [ -z $ppid ] || ! [[ $ppid =~ $re ]] || [ $cmd != 'ssh' ]; then
	exit 0
fi

if [ "$(uname)" == "Darwin" ]; then
	pid=$(pgrep -P $ppid)
	current_pid=$$
else
	pid=$(ps --no-headers --ppid $ppid -o pid)
	current_pid=$$
fi
pid="${pid[@]/$current_pid}"

if [ -z $pid ]; then
	echo ""
else
	echo "| CMD:$(ps -p $pid -o pid) | sed 1d"
fi
