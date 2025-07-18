#! /sbin/bash

MONITOR_OPTION="$1"

case $MONITOR_OPTION in
    0)
        ln -sfn ~/.config/hypr/monitor-config/dual-monitor.conf ~/.config/hypr/hyprMonitor.conf
    ;;
    1)
        ln -sfn ~/.config/hypr/monitor-config/hdmi-only.conf ~/.config/hypr/hyprMonitor.conf
    ;;
    2)
        ln -sfn ~/.config/hypr/monitor-config/monitor-only.conf ~/.config/hypr/hyprMonitor.conf
    ;;
    *)
        ln -sfn ~/.config/hypr/monitor-config/screen-mirror.conf ~/.config/hypr/hyprMonitor.conf
    ;;
esac

hyprctl reload &
sh ~/.config/eww/upEww.sh
