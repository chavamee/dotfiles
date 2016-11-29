#!/bin/bash

CURRENT_ACTION=$1
CURRENT_CMD=playerctl
if playerctl --list-all 2>&1 | grep 'No'; then
CURRENT_CMD=mpc
fi

if [[ $CURRENT_ACTION == 'toggle' && $CURRENT_CMD == 'playerctl' ]]; then
    CURRENT_ACTION='play-pause'
fi

if [[ $CURRENT_ACTION == 'prev' && $CURRENT_CMD == 'playerctl' ]]; then
    CURRENT_ACTION='previous'
fi

exec $CURRENT_CMD $CURRENT_ACTION

