#!/usr/bin/bash

if [[ "$1" = "name" ]]; then
    name=$(bluetoothctl info | grep Name | cut -b 8-)
    if [ "$name" = "" ]; then
        echo "Desconectado" && exit
    fi
    echo $name
fi

if [[ "$1" = "batt" ]]; then
    battery=$(bluetoothctl info | grep "Battery" | awk '{print $4}' | tr -d '()')
    if [ "$battery" = "" ]; then
        echo "" && exit
    fi
    echo "$battery%"
fi

if [[ "$1" = "icon" ]]; then
    icon=$(rfkill list "$(rfkill list | grep Bluetooth | cut -c 1)"| grep Soft | awk '{print $3}')
    if [ "$icon" = "yes" ]; then
        echo "" && exit
    fi
    echo "" 
fi

exit