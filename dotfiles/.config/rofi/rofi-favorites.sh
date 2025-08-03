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
    launcher_paths=$(awk -F= '/^\[Containments\]\[[0-9]+\]\[Applets\]\[[0-9]+\]\[Configuration\]\[General\]/ { in_section=1 } in_section && /^launchers=/ { print $2; exit }' "$CONFIG" | tr ',' '\n' | sed 's|^file://||')

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
pad=${#total} # Number of digits
i=0

# Function to get index of element in array
get_index() {
    local item="$1"
    local i=0
    for fav in "${favorites[@]}"; do
        if [[ "$fav" == "$item" ]]; then
            echo "$i"
            return
        fi
        ((i++))
    done
    echo "-1"
}

# Loop over array
printf "%s\n" "${favorites[@]}" | while read -r favorite ; do
    # Retrieve the current favorite app
    idx=$(get_index "$favorite")
    ((idx++))
    padded_idx=$(printf "%0${pad}d" "$idx")
    padded_total=$(printf "%0${pad}d" "$total")

    # Extract relevant information from the .desktop files
    if [ -f "$favorite" ]; then
        name=$(awk -F "=" '/^Name=/ {print $2; exit}' "$favorite")
        command=$(awk -F "=" '/^Exec=/ {print $2; exit}' "$favorite")
        icon=$(awk -F "=" '/^Icon=/ {print $2; exit}' "$favorite")
    else
        continue
    fi

    if [ $# -eq 0 ]; then
        echo -en "${padded_idx}/${padded_total} | ${name}\0icon\x1f${icon}\n"
    fi

    if [ $# -eq 1 ]; then
        input="$1"
        clean_input=$(echo "$input" | sed 's/^[0-9]\+\/[0-9]\+ | //')
        if [ "$clean_input" == "$name" ]; then
            # notify-send "$favorite" # for debugging
            gtk-launch "$(basename "$favorite")" >/dev/null 2>&1 &
            exit
        fi
    fi
done
