#!/bin/sh

output="$(checkupdates)"
number="$(echo "$output" | wc -l)"
text="$number "

if (( $number > 20 ))
then
    tooltip="$(echo "$output" | head -n 20 | sed -z 's/\n/\\n/g')"
    tooltip+='...'
else
    tooltip="$(echo "$output" | sed -z 's/\n/\\n/g')"
    tooltip=${tooltip::-2}
fi

echo "{\"text\":\""$text"\", \"tooltip\":\""$tooltip"\"}"
exit 0
