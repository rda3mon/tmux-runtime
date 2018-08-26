#!/usr/bin/env bash

ppid=$1
cmd=$2
re='^[0-9]+$'

if [ -z $ppid ] || ! [[ $ppid =~ $re ]] || [ $cmd != 'ssh' ]; then
	exit 0
fi

pid=$(ps --no-headers --ppid $ppid -o pid)
current_pid=$$

pid="${pid[@]/$current_pid}"

if [ -z $pid ]; then
	echo ""
else
	#echo "| CMD:$(ps --no-headers --ppid $ppid -o pid) "
	echo $SSH_CLIENT
fi
