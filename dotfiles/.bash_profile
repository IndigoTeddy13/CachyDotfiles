#!/bin/bash

# Load ~/.bashrc if possible
if [ -r ~/.bashrc ]; then
    source ~/.bashrc
fi

# Check if the script has already been run during login
if [ ! -f "$HOME/.pywal_update_done" ]; then
    if [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]; then
        nohup $HOME/.local/bin/gnome-pywal-update > /dev/null 2>&1 &
        disown
    elif [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
        nohup $HOME/.local/bin/kde-pywal-update > /dev/null 2>&1 &
        disown
    else
        waypaper --restore
    fi
    # Create a file to indicate that the update has been done
    touch "$HOME/.pywal_update_done"
else
    # If already run, just process the wallpaper once
    if [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]; then
        WALLPAPER_PATH=$(gsettings get org.gnome.desktop.background picture-uri-dark | sed -E "s/^'|'$//g" | sed 's|file://||')
        magick "$WALLPAPER_PATH" -resize 1920x1080 -colorspace sRGB /tmp/wall.png
        wal --cols16 darken -n -i /tmp/wall.png
    elif [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
        WALLPAPER_PATH="$(get-kde-wallpaper)contents/images_dark/1080x1920.png"
        wal --cols16 darken -n -i "$WALLPAPER_PATH"
    else
        waypaper --restore
    fi
fi
