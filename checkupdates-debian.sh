#!/usr/bin/env bash

number="$(apt list --upgradable 2>/dev/null | wc -l)"
text="$number"
tooltip="${text} packages"

echo "{\"text\":\""$text"\", \"tooltip\":\""$tooltip"\"}"
exit 0
