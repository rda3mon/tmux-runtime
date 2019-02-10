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

full_command=$(ps --no-headers --ppid $ppid -o command)
pid_command=$(ps --no-headers --ppid $ppid -o pid)
cpu_command=$(ps --no-headers --ppid $ppid -o %cpu)
memory_command=$(ps --no-headers --ppid $ppid -o %mem)
if [ -z $pid ]; then
	full_command=$(ps --no-headers --pid $ppid -o command)
	pid_command=$(ps --no-headers --pid $ppid -o pid)
	cpu_command=$(ps --no-headers --pid $ppid -o %cpu)
	memory_command=$(ps --no-headers --pid $ppid -o %mem)
fi

if [ $cmd == 'ssh' ]; then
	ssh_host=$(echo "$full_command" | grep -o '[\.a-zA-Z0-9-]*$')
	ssh_user=$(ssh -G $ssh_host | grep '^user ' | sed 's/user //')
	ssh_port=$(ssh -G $ssh_host | grep '^port ' | sed 's/port //')

	remote_mem=$(ssh -l $ssh_user -p $ssh_port $ssh_host "bash -s" < /home/mallikarjunv/.tmux/plugins/scripts/mem_percentage.sh)
	remote_load=$(ssh -l $ssh_user -p $ssh_port $ssh_host "bash -s" < /home/mallikarjunv/.tmux/plugins/scripts/load_info.sh)

	echo "| CMD:$full_command R:[ $remote_mem | $remote_load ] L:[ PID:$pid_command | CPU:$cpu_command | Mem:$memory_command ] "
else
	echo "| CMD:$full_command L:[ PID:$pid_command | CPU:$cpu_command | Mem:$memory_command ]"
fi
