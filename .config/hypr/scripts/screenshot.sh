#!/bin/bash

if [ -z $1]; then
	echo "you need to pass an argument"
	exit 1
fi

screenshots_dir="$(xdg-user-dir PICTURES)/screenshots"

if [ ! -d $screenshots_dir ]; then
       	mkdir $screenshots_dir
fi

if [ $1 == "monitor" ]; then
	active_workspace_monitor=$(hyprctl -j activeworkspace | jq -r "(.monitor)")
	screenshoot_filename="$(xdg-user-dir PICTURES)/screenshots/$(date +"%d-%m-%Y-%H%S")-$active_workspace_monitor.webp"
	grim -s 2 -o $active_workspace_monitor $screenshoot_filename
	wl-copy < $screenshoot_filename
fi

if [ $1 == "area" ]; then
	screenshoot_filename="$(xdg-user-dir PICTURES)/screenshots/$(date +"%d-%m-%Y-%H%S")-area.webp"
	grim -s 2 -g "$(slurp -d)" $screenshoot_filename
	wl-copy < $screenshoot_filename
fi
