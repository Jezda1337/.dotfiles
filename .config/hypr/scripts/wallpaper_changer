#!/bin/bash

effects=("grow" "wave" "any" "fade")
random_index=$((RANDOM % ${#effects[@]}))
img=$(sxiv -to ~/Pictures/wallpapers/ | awk -F'/' '{print $NF}')
swww img -t ${effects[random_index]} ~/Pictures/wallpapers/$img
