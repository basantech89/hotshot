#!/bin/bash
IFS=$(echo -en "\n\b")
for path in $(find ~/.config -name wine*)
do
    if [ -d "$path" ]; then
	rm -rf $path
    else
	rm -f "$path"
    fi
done
