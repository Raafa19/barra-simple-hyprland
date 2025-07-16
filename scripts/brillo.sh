#!/usr/bin/bash

brillo=/sys/class/backlight/intel_backlight
actual=$(cat $brillo/actual_brightness)
max=$(cat $brillo/max_brightness)
new=$2

brillo-actual() {
    valor=$((($actual * 100)/$max))
    echo $valor
}

set-brillo() {
    if [ $new -gt 1 ]; then
        light -S $new
    fi
}

getclass () {
    local val=$(brillo-actual)
    if [ "$val" -lt "1" ]; then
        echo "metric-off" && exit
    fi
    echo "metric"
}

[ "$1" = "getclass" ] && getclass && exit
[ "$1" = "brillo-actual" ] && brillo-actual && exit
[ "$1" = "set-brillo" ] && set-brillo && exit
exit