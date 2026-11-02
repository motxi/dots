#! /usr/bin/env bash

DIR="${HOME}/Pictures/Screen"
FORMAT='%F_%H%M%S.png'

mkDIR --parents "${DIR}"

scrot \
    --silent \
    --freeze \
    --select \
    --pointer \
    --overwrite \
    --exec 'xclip -selection clipboard -target image/png -in "$f"' \
    "${DIR}/${FORMAT}"

notify-send --app-name scrot 'Screenshot Saved!'
