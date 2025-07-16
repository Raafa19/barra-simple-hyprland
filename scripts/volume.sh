#!/usr/bin/bash

getid() {
    wpctl status | grep "*" | awk 'NR==1{print $3}'
}

ismuted() {
    local id=$(getid)
    wpctl get-volume $id | awk '{print $3}'
}

getvolume() {
    local id=$(getid)
    wpctl get-volume $id | awk '{print $2 * 100}'
}

getvolumelisten() {
    getvolume
    pactl subscribe \
      | grep --line-buffered "Event 'change' on sink " \
      | while read -r
      do getvolume;
    done
}

nextvolume=$2
setvolume() {
    local id=$(getid)
    if [ $nextvolume -gt 1 ]; then
        wpctl set-volume $id $nextvolume% --limit 1.0
    fi
    exit
}

geticonlisten() {
    pactl subscribe \
      | grep --line-buffered "Event 'change' on sink " \
      | while read -r
      do 
        local vol=$(getvolume);
        local muted=$(ismuted);
        if [ "$muted" = "[MUTED]" ]; then
            echo ""
        elif (( $(echo "$vol < 1" | bc) )); then
            echo ""
        elif (( $(echo "$vol > 50" | bc) )); then
            echo ""
        else 
            echo ""
        fi
    done
}

getclasslisten() {
    pactl subscribe \
      | grep --line-buffered "Event 'change' on sink " \
      | while read -r
      do
        local vol=$(getvolume)
        local muted=$(ismuted);
        if [ "$muted" = "[MUTED]" ]; then
            echo "metric-off"
        elif (( $(echo "$vol < 1" | bc) )); then
            echo "metric-off"
        else
            echo "metric"
        fi
    done
}

mute() {
    local id=$(getid)
    wpctl set-mute $id toggle
    exit
}

[ "$1" = "getvolumelisten" ] && getvolumelisten
[ "$1" = "getclasslisten" ] && getclasslisten
[ "$1" = "geticonlisten" ] && geticonlisten

[ "$1" = "setvolume" ] && setvolume && exit
[ "$1" = "mute" ] && mute && exit