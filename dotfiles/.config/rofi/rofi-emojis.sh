#!/usr/bin/env bash
rofi -modi "emoji" \
     -show emoji \
     -kb-secondary-copy "" \
     -kb-custom-1 "Ctrl+c" \
     -emoji-mode insert_no_copy \
     -emoji-format '{emoji} <span weight="bold">{name}</span>'