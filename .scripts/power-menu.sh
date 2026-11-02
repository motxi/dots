#! /usr/bin/env bash

pkill --exact i3-nagbar && exit 0

exec i3-nagbar \
    --font 'pango:Mononoki Nerd Font 12' \
    --message 'System Power Menu:' \
    --button-no-terminal 'Logout' 'i3-msg exit' \
    --button-no-terminal 'Lock' 'i3lock --ignore-empty-password' \
    --button-no-terminal 'Suspend' 'systemctl suspend && pkill --exact i3-nagbar' \
    --button-no-terminal 'Reboot' 'systemctl reboot' \
    --button-no-terminal 'Power Off' 'systemctl poweroff'
