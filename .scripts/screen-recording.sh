#! /usr/bin/env bash

DIR="${HOME}/Videos/Screen"
FORMAT='%F_%H%M%S.mp4'

mkdir --parents "${DIR}"

PID_FILE="${XDG_RUNTIME_DIR:-/tmp}/screen_recording.pid"
LOG_FILE="${XDG_RUNTIME_DIR:-/tmp}/screen_recording.log"

if [[ -f "${PID_FILE}" ]] && kill -0 "$(cat "${PID_FILE}")" 2> /dev/null; then
    kill -INT "$(cat "${PID_FILE}")"
    rm --force "${PID_FILE}"

    notify-send 'Screen Recording' 'Stopped'

    exit 0
fi

RESOLUTION=$(xrandr | awk '/\*/ {print $1; exit}')
AUDIO_SINK="$(pactl get-default-sink).monitor"
OUTPUT="${DIR}/$(date +%F_%H%M%S).mp4"

# Screen and Desktop Audio
ffmpeg_command=(
    ffmpeg
    -nostdin                                            # Ignore stdin.
    -hide_banner                                        # Hide the startup banner.
    -loglevel warning                                   # Print only warnings and errors.

    -thread_queue_size 1024                             # Enlarge the video input buffer.
    -f x11grab                                          # Capture an X11 display.
    -framerate 30                                       # Capture 30 frames per second.
    -video_size "${RESOLUTION}"                         # Capture the full screen size.
    -i "${DISPLAY:-:0}"                                 # Use the current X display.

    -thread_queue_size 1024                             # Enlarge the audio input buffer.
    -f pulse                                            # Read audio through the Pulse layer.
    -i "${AUDIO_SINK}"                                  # Record the desktop audio.
)

# Microphone Mixed with Desktop Audio (Optional)
if [[ $1 == --record-mic ]]; then
    ffmpeg_command+=(
        -thread_queue_size 1024                         # Enlarge the mic input buffer.
        -f pulse                                        # Read the mic through the Pulse layer.
        -i default                                      # Record the default microphone.

        -filter_complex                                 # Apply a filter graph.
        "[1:a][2:a]amix=inputs=2:duration=longest[a]"   # Mix desktop audio and mic into one track.
        -map 0:v                                        # Keep the video stream.
        -map "[a]"                                      # Use the mixed audio stream.
    )
fi

# Encoding and Output
ffmpeg_command+=(
    -c:v libx264                                        # Encode the video as H.264.
    -preset medium                                      # Favor speed over compression.
    -crf 26                                             # Set the quality, where lower is better.
    -pix_fmt yuv420p                                    # Stay compatible with most players.

    -c:a aac                                            # Encode audio as AAC.
    -b:a 128k                                           # Set the audio bitrate.
    -ac 2                                               # Downmix audio to stereo.

    -movflags +frag_keyframe+empty_moov                 # Keep the file playable even if interrupted.

    "${OUTPUT}"                                         # Write to the output file.
)

notify-send 'Screen Recording' "Started: ${OUTPUT}"

echo "$$" > "${PID_FILE}"
exec "${ffmpeg_command[@]}" > "${LOG_FILE}" 2>&1
