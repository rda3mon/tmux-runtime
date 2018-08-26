#!/usr/bin/env bash

# Credit: Referenced from https://github.com/tmux-plugins/tpm 

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#source "$CURRENT_DIR/scripts/helpers.sh"

cpu_interpolation=(
	"\#{mem_percentage}"
	"\#{process_info}"
	"\#{ssh_info}"
)
cpu_commands=(
	"$CURRENT_DIR/scripts/mem_percentage.sh"
	"$CURRENT_DIR/scripts/process_info.sh"
	"$CURRENT_DIR/scripts/ssh_info.sh"
)

get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value="$(tmux show-option -gqv "$option")"
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

get_tmux_window_option() {
	local option="$1"
	local default_value="$2"
	local option_value="$(tmux showw -gv "$option")"
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

do_interpolation() {
	local all_interpolated="$1"
	echo $all_interpolated > /tmp/test
	for ((i=0; i<${#cpu_commands[@]}; i++)); do
		all_interpolated=${all_interpolated/${cpu_interpolation[$i]}/${cpu_commands[$i]}}
	done
	echo "$all_interpolated"
}

set_tmux_option() {
	local option=$1
	local value=$2
	tmux set-option -gq "$option" "$value"
}

set_tmux_window_option() {
	local option=$1
	local value=$2
	tmux setw -gq "$option" "$value"
}

update_tmux_option() {
	local option=$1
	local option_value=$(get_tmux_option "$option")
	local new_option_value=$(do_interpolation "$option_value")
	set_tmux_option "$option" "$new_option_value"
}

update_tmux_window_option() {
	local option=$1
	local option_value=$(get_tmux_window_option "$option")
	local new_option_value=$(do_interpolation "$option_value")
	set_tmux_window_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
	update_tmux_window_option "pane-border-format"
}
main
