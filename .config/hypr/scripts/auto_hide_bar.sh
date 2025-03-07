#!/bin/bash

# Get screen dimensions and scaling
get_screen_info() {
  monitor_info=$(hyprctl monitors -j | jq -r '.[0]')
  width=$(echo "$monitor_info" | jq -r '.width')
  height=$(echo "$monitor_info" | jq -r '.height')
  scale=$(echo "$monitor_info" | jq -r '.scale // 1')
  echo "$width $height $scale"
}

# Get current mouse position
get_mouse_position() {
  cursor_info=$(hyprctl cursorpos -j)
  x=$(echo "$cursor_info" | jq -r '.x')
  y=$(echo "$cursor_info" | jq -r '.y')
  echo "$x $y"
}

# Main loop
main() {
  read width height scale <<<$(get_screen_info)
  scaled_height=$(echo "$height / $scale" | bc -l | awk '{print int($1)}')

  bottom_threshold=$(echo "$scaled_height - 5" | bc -l | awk '{print int($1)}')
  bar_height=15 # Adjust to match your bar height
  exit_threshold=$(echo "$scaled_height - $bar_height - 5" | bc -l | awk '{print int($1)}')

  window_visible=false

  echo "Screen dimensions: ${width}x${height} (scale: $scale)"
  echo "Scaled height: $scaled_height"
  echo "Bottom threshold: $bottom_threshold"
  echo "Exit threshold: $exit_threshold"
  echo "Monitoring for mouse position..."

  # Make sure eww daemon is running
  if ! pgrep -x "eww" >/dev/null; then
    echo "Starting eww daemon..."
    eww daemon
    sleep 1
  fi

  # Initially close the window
  eww close main 2>/dev/null || true

  while true; do
    read x y <<<$(get_mouse_position)

    if [ "$y" -ge "$bottom_threshold" ]; then
      if [ "$window_visible" = "false" ]; then
        echo "BOTTOM DETECTED! Y: $y >= Threshold: $bottom_threshold"
        eww open main
        window_visible=true
      fi
    elif [ "$y" -lt "$exit_threshold" ]; then
      if [ "$window_visible" = "true" ]; then
        echo "EXITED BAR AREA! Y: $y < Threshold: $exit_threshold"
        eww close main
        window_visible=false
      fi
    fi

    sleep 0.2
  done
}

# Check dependencies
for cmd in jq bc hyprctl eww; do
  if ! command -v $cmd &>/dev/null; then
    echo "Error: $cmd is required but not installed."
    exit 1
  fi
done

main
