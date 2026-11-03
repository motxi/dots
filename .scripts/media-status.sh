#! /usr/bin/env bash

# Pass through the two JSON header lines.
read -r line && echo "${line}"
read -r line && echo "${line}"

has_playerctl=0

command -v playerctl > /dev/null 2>&1 && has_playerctl=1

# The first player in this list that is "Playing" wins.
PRIORITY=(spotifast spotify firefox)

HIGHLIGHT='#e0c341'

while read -r line; do
    prefix=''

    if [[ ${line} == ,* ]]; then
        prefix=','
        line=${line:1}
    fi

    if (( has_playerctl )); then
        info=''

        mapfile -t players < <(timeout 1 playerctl \
            metadata \
            --all-players \
            --format '{{playerName}}|{{status}}|{{artist}} - {{title}}' 2> /dev/null)

        for priority in "${PRIORITY[@]}"; do
            for player in "${players[@]}"; do
                if [[ ${player} == "${priority}|Playing|"* ]]; then
                    info=${player#"${priority}|Playing|"}
                    break 2
                fi
            done
        done

        if [[ -n ${info} ]]; then
            info=${info//\\/\\\\} # Escape backslashes.
            info=${info//\"/\\\"} # Escape quotes.

            line="[{\"full_text\":\"${info}\",\"name\":\"spotify\",\"color\":\"${HIGHLIGHT}\"},${line:1}"
        fi
    fi

    echo "${prefix}${line}"
done
