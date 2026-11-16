#! /usr/bin/env bash

xrandr \
    --output DP-1 \
    --primary \
    --mode 2560x1440 \
    --pos 0x740 \
    --rotate normal \
    --rate 240.00

xrandr \
    --output DP-2 \
    --right-of DP-1 \
    --mode 2560x1440 \
    --pos 2560x0 \
    --rotate right \
    --rate 240.00

