#!/bin/bash

# Cleanup function to ensure proper exit
cleanup() {
  echo "Exiting script..."
  # Make sure to close the window before exiting
  eww close main 2>/dev/null || true
  exit 0
}

# Set up trap for clean exit
trap cleanup SIGINT SIGTERM EXIT

# Get screen dimensions and scaling
get_screen_info() {
  monitor_info=$(hyprctl monitors -j 2>/dev/null | jq -r '.[0]' 2>/dev/null)
  if [ $? -ne 0 ]; then
    echo "Error: Could not get monitor info. Is Hyprland running?"
    return 1
  fi

  width=$(echo "$monitor_info" | jq -r '.width')
  height=$(echo "$monitor_info" | jq -r '.height')
  scale=$(echo "$monitor_info" | jq -r '.scale // 1')
  echo "$width $height $scale"
  return 0
}

# Get current mouse position
get_mouse_position() {
  cursor_info=$(hyprctl cursorpos -j 2>/dev/null)
  if [ $? -ne 0 ]; then
    echo "Error: Could not get cursor position. Is Hyprland running?"
    return 1
  fi

  x=$(echo "$cursor_info" | jq -r '.x')
  y=$(echo "$cursor_info" | jq -r '.y')
  echo "$x $y"
  return 0
}

# Main loop
main() {
  # Initial setup
  read width height scale <<<$(get_screen_info) || return 1

  scaled_height=$(echo "$height / $scale" | bc -l | awk '{print int($1)}')
  bottom_threshold=$(echo "$scaled_height - 5" | bc -l | awk '{print int($1)}')
  bar_height=15 # Adjust to match your bar height
  exit_threshold=$(echo "$scaled_height - $bar_height - 5" | bc -l | awk '{print int($1)}')

  window_visible=false
  delay_count=0
  hide_delay=2 # Number of checks before hiding (not seconds)

  echo "Screen dimensions: ${width}x${height} (scale: $scale)"
  echo "Scaled height: $scaled_height"
  echo "Bottom threshold: $bottom_threshold"
  echo "Exit threshold: $exit_threshold"
  echo "Hide checks before hiding: $hide_delay"
  echo "Monitoring for mouse position..."

  # Ensure eww is closed initially
  eww close main 2>/dev/null || true

  while true; do
    # Check if Hyprland is still running
    if ! pgrep -x "Hyprland" >/dev/null; then
      echo "Hyprland not detected. Waiting for it to start again..."
      sleep 5
      continue
    fi

    # Get mouse position
    read x y <<<$(get_mouse_position) || {
      sleep 2
      continue
    }

    # Bottom detection logic
    if [ "$y" -ge "$bottom_threshold" ]; then
      # Reset hide counter when mouse is at bottom
      delay_count=0

      if [ "$window_visible" = "false" ]; then
        echo "BOTTOM DETECTED! Y: $y >= Threshold: $bottom_threshold"
        eww open main 2>/dev/null || {
          echo "Error opening eww window. Is eww running?"
          eww daemon 2>/dev/null
          sleep 1
          eww open main 2>/dev/null || true
        }
        window_visible=true
      fi
    elif [ "$y" -lt "$exit_threshold" ] && [ "$window_visible" = "true" ]; then
      # Count checks while mouse is outside the threshold
      delay_count=$((delay_count + 1))

      if [ "$delay_count" -eq 1 ]; then
        echo "EXITED BAR AREA! Y: $y < Threshold: $exit_threshold"
        echo "Will hide bar after $hide_delay checks..."
      fi

      if [ "$delay_count" -ge "$hide_delay" ]; then
        echo "Hiding bar after delay"
        eww close main 2>/dev/null || true
        window_visible=false
        delay_count=0
      fi
    fi

    # Short sleep to keep responsive while reducing CPU usage
    sleep 0.3
  done
}

# Check dependencies
for cmd in jq bc hyprctl eww; do
  if ! command -v $cmd &>/dev/null; then
    echo "Error: $cmd is required but not installed."
    exit 1
  fi
done

# Start the main function
main

# Ensure cleanup happens when script exits
cleanup
