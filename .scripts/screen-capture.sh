#! /usr/bin/env bash

readonly dir="${HOME}/Pictures/Screen"
readonly format='%F_%H%M%S.png'

mkdir --parents "${dir}"

scrot \
    --silent \
    --freeze \
    --select \
    --pointer \
    --overwrite \
    --exec 'xclip -selection clipboard -target image/png -in "$f"' \
    "${dir}/${format}"

notify-send --app-name scrot 'Screenshot Saved!'
