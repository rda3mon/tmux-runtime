#!/usr/bin/env bash

ppid=$1
cmd=$2
re='^[0-9]+$'

if [ -z $ppid ] || ! [[ $ppid =~ $re ]]; then
	exit 0
fi

pid=$(ps --no-headers --ppid $ppid -o pid)
current_pid=$$

pid="${pid[@]/$current_pid}"

if [ -z $pid ]; then
	echo ""
else
	full_command=$(ps --no-headers --ppid $ppid -o command)

	if [ $cmd == 'ssh' ]; then
		ssh_host=$(echo "$full_command" | grep -o '[\.a-zA-Z0-9-]*$')
		ssh_user=$(ssh -G $ssh_host | grep '^user ' | sed 's/user //')
		ssh_port=$(ssh -G $ssh_host | grep '^port ' | sed 's/port //')

		remote_mem=$(ssh -l $ssh_user -p $ssh_port $ssh_host "bash -s" < /home/mallikarjunv/.tmux/plugins/scripts/mem_percentage.sh)
		remote_load=$(ssh -l $ssh_user -p $ssh_port $ssh_host "bash -s" < /home/mallikarjunv/.tmux/plugins/scripts/load_info.sh)

		echo "| CMD:$(ps --no-headers --ppid $ppid -o command) R:[ $remote_mem | $remote_load ] L:[ PID:$(ps --no-headers --ppid $ppid -o pid) | CPU:$(ps --no-headers --ppid $ppid -o %cpu) | Mem:$(ps --no-headers --ppid $ppid -o %mem) ] "
	else
		echo "| CMD:$(ps --no-headers --ppid $ppid -o command) L:[ PID:$(ps --no-headers --ppid $ppid -o pid) | CPU:$(ps --no-headers --ppid $ppid -o %cpu) | Mem:$(ps --no-headers --ppid $ppid -o %mem) ]"
	fi

fi
