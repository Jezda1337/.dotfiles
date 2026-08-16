#!/bin/bash

# Store the PID of the last sleep command
LAST_TIMER_PID=""

function notify() {
	# Remove spaces around = in variable assignments
	local command="$1"
	local widget_name="$2"

	# Check if both arguments are provided
	if [ -z "$command" ] || [ -z "$widget_name" ]; then
		echo "Usage: notify <command> <widget_name>"
		echo "Example: notify 'pactl get-sink-volume @DEFAULT_SINK@' notify"
		return 1
	fi

	# If there's an existing timer, kill it
	if [ ! -z "$LAST_TIMER_PID" ] && kill -0 "$LAST_TIMER_PID" 2>/dev/null; then
		kill "$LAST_TIMER_PID" 2>/dev/null
	fi

	# Check if window is already open
	if ! eww active-windows | grep -q "$widget_name"; then
		eww open "$widget_name"
	fi

	# Get the output of the command
	content=$(eval "$command")

	# Update the eww widget
	eww update "notify_text=${content}"

	# Set new timer and store its PID
	(
		sleep 2
		if eww active-windows | grep -q "$widget_name"; then
			eww close "$widget_name"
		fi
	) &
	LAST_TIMER_PID=$!
	disown $LAST_TIMER_PID
}

# If script is called directly (not sourced)
if [ "${BASH_SOURCE[0]}" -ef "$0" ]; then
	notify "$@"
fi
