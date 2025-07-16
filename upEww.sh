#!/usr/bin/bash

path="$( cd "$(dirname "$0")" ; pwd -P )"
actMonitor="$( hyprctl monitors | grep ID | wc -l )"


# echo $path
killall eww

eww daemon -c $path &

if [ $actMonitor = 1 ]; then
    hyprctl switchxkblayout all 1 &
    eww open mainbar0 -c $path  &
    
else
    eww open mainbar -c $path  &
    eww open board -c $path  &
fi