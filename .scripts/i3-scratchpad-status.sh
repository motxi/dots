#! /usr/bin/env bash

# Pass through the two JSON header lines.
read -r line && echo "${line}"
read -r line && echo "${line}"

command -v jq > /dev/null 2>&1 || exec cat

while read -r line; do
    count=$(i3-msg -t get_tree 2> /dev/null | jq \
        '[.. | objects | select(.name == "__i3_scratch")][0].floating_nodes | length' \
        2> /dev/null)

    if [[ ${count} =~ ^[0-9]+$ ]] && (( count > 0 )); then
        line="${line%]},{\"full_text\":\"Scratchpad: ${count}\",\"name\":\"scratchpad\"}]"
    fi

    echo "${line}"
done
