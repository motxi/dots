#! /usr/bin/env bash

xrandr --output DP-2 --primary --mode 2560x1440 --pos 0x0 --rotate normal

xrandr \
    --output DP-1 --off \
    --output HDMI-1 --off \
    --output HDMI-2 --off
