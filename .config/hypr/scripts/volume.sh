#!/usr/bin/env bash

ICON="/usr/share/icons/Papirus-Dark/48x48/devices/audio-speakers.svg"
SYNC_TAG="string:x-canonical-private-synchronous:volume"

get_volume_info() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null
}

notify_user() {
    -- Small micro-pause to ensure PipeWire commits the state change
    usleep 10000 2>/dev/null || sleep 0.01

    local info=$(get_volume_info)
    if [[ "$info" == *"[MUTED]"* ]]; then
        notify-send -h "$SYNC_TAG" -i "$ICON" "Muted" -u normal
    else
        local raw_vol=$(echo "$info" | awk '{print $2}')
        local percent=$(awk "BEGIN {print int($raw_vol * 100 + 0.5)}")
        notify-send -h "$SYNC_TAG" -i "$ICON" "${percent}%" -u normal
    fi
}

case "$1" in
    --inc)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        notify_user
        ;;
    --dec)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        notify_user
        ;;
    --toggle)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        notify_user
        ;;
    --get)
        raw_vol=$(get_volume_info | awk '{print $2}')
        awk "BEGIN {print int($raw_vol * 100)}"
        ;;
    --get-icon)
        info=$(get_volume_info)
        if [[ "$info" == *"[MUTED]"* ]]; then
            echo " "
        else
            echo " "
        fi
        ;;
esac
