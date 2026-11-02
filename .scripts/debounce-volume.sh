#! /usr/bin/env bash

set -u

readonly LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/debounce-volume.lock"
readonly HOLD_TIME='0.05'

if [[ $# -ne 1 ]]; then
    echo "Usage: ${0##*/} <step, e.g. +1% or -1%>" >&2
    exit 1
fi

readonly STEP="$1"

# Take a non-blocking lock. If another instance already holds it, this run is
# the duplicate event, so exit quietly without touching the volume.
exec 9> "${LOCK_FILE}"
flock -n 9 || exit 0

wpctl set-volume @DEFAULT_AUDIO_SINK@ "${STEP}"

# Keep the lock briefly so the duplicate launch can't acquire it.
sleep "${HOLD_TIME}"
