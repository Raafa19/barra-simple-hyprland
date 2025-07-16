eww_path="$PWD/"

state=$(eww active-windows -c "$eww_path" | grep $1)


if [ "$state" = "$1: $1" ]; then
    eww close $1 -c "$eww_path"
else
    eww open $1 -c "$eww_path"
fi