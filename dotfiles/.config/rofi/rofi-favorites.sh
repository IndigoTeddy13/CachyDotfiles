#! /usr/bin/bash

# Source: https://github.com/luiscrjunior/rofi-favorites
CONFIG="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
SEARCH_DIRS=(
    "/usr/share/applications"
    "$HOME/.local/share/applications"
    "/var/lib/flatpak/exports/share/applications"
    "$HOME/Desktop"
)

# Retrieve list of favorites from KDE Plasma
get_favorites() {
    launcher_paths=$(awk -F= '/^\[Containments\]/{s=0} /^\[Containments\]\[2\]\[Applets\]\[5\]\[Configuration\]\[General\]/{s=1} s && /^launchers=/{print $2; exit}' $CONFIG | tr ',' '\n' | sed 's|^file://||')

    echo "$launcher_paths" | while read -r path; do
        if [[ "$path" == applications:* ]]; then
            # Strip 'applications:' prefix
            file="${path#applications:}"
            found=""
            for dir in "${SEARCH_DIRS[@]}"; do
                if [[ -f "$dir/$file" ]]; then
                    found="$dir/$file"
                    break
                fi
            done
            if [[ -n "$found" ]]; then
                echo "$found"
            else
                echo "Warning: Desktop file $file not found in known directories." >&2
            fi
        else
            # Already a full path
            echo "$path"
        fi
    done
}

# Store as an array
favorites=( $(get_favorites) )
total=${#favorites[@]}
pad_length=${#total} # Number of digits

# Loop over array
for (( i=0; i<total; i++ )); do
    favorite="${favorites[i]}"
    index=$((i + 1))
    # Apply padding
    padded_index=$(printf "%0${pad_length}d" "$index")
    padded_total=$(printf "%0${pad_length}d" "$total")
    
    # Extract relevant informaiton from .desktop files
    if [ -f "$favorite" ]; then
        name=$(cat $favorite | awk -F "=" '/Name=/ {print $2}' | head -1)
        command=$(cat $favorite | awk -F "=" '/Exec=/ {print $2}' | head -1)
        icon=$(cat $favorite | awk -F "=" '/Icon=/ {print $2}' | head -1)
    else
        continue
    fi

    if [ $# -eq 0 ]; then
        echo -en " ${padded_index}/${padded_total} | ${name}\0icon\x1f${icon}\n"
    fi

    if [ $# -eq 1 ]; then
        chosen="$1"
        if [ "$chosen" == "$name" ]; then
            # notify-send "$favorite" # for debugging
            gtk-launch ${favorite} >/dev/null 2>&1 &
            exit
        fi
    fi

done