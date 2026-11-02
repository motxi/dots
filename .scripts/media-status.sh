#! /usr/bin/env bash

# Pass through the two JSON header lines.
read -r line && echo "${line}"
read -r line && echo "${line}"

has_playerctl=0

# Check if the command exists only once.
command -v playerctl > /dev/null 2>&1 && has_playerctl=1

fetch_player_info() {
    timeout 1 playerctl metadata \
        --player spotify \
        --format "$1" 2> /dev/null
}

HIGHLIGHT='#e0c341'

while read -r line; do
    prefix=""

    if [[ ${line} == ,* ]]; then
        prefix=','
        line=${line:1}
    fi

    if (( has_playerctl )); then
        STATUS=$(playerctl status --player spotify)

        if [[ ${STATUS} == "Playing" ]]; then
            FINAL=$(fetch_player_info '{{artist}} - {{title}}')

            if [[ -n ${FINAL} ]]; then
                info=${FINAL//\\/\\\\} # Escape backslashes.
                info=${info//\"/\\\"} # Escape quotes.

                line="[{\"full_text\":\"${info}\",\"name\":\"spotify\",\"color\":\"${HIGHLIGHT}\"},${line:1}"
            fi
        fi
    fi

    echo "${prefix}${line}"
done
