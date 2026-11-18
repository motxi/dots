#! /usr/bin/env bash

DIR="${HOME}/Pictures/Screen"
FORMAT='%F_%H%M%S.png'

mkdir --parents "${DIR}"

scrot \
    --silent \
    --freeze \
    --select \
    --pointer \
    --overwrite \
    --exec 'xclip -selection clipboard -target image/png -in "$f"; notify-send --app-name scrot --icon "$f" "Screenshot Saved!"' \
    "${DIR}/${FORMAT}"
