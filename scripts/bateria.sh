#!/usr/bin/bash

bat=/sys/class/power_supply/BAT0/
per=$(cat $bat/capacity)
status=$(cat $bat/status)

icono() {
	if [ "$status" = "Charging" ]; then
		echo "" && exit
	elif [ "$per" -gt "90" ]; then
		icono=""
	elif [ "$per" -gt "75" ]; then
		icono=""
	elif [ "$per" -gt "50" ]; then
		icono=""
	elif [ "$per" -gt "25" ]; then
		icono=""
	else
		echo "" &&
		dunstify "Batería baja" -u critical -r 9991 && exit

	fi
	echo "$icono"
}

[ "$1" = "icono" ] && icono && exit
exit