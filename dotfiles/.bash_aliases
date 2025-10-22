#!/usr/bin/env bash

# Function to update list of flatpaks
function update_flatpak_list() {
    # Specify the backup file path
    local list_file="$HOME/.config/flatpak-list.txt"

    # Create a temporary file with the current list of flatpak apps
    local temp_list=$(mktemp)
    flatpak list --columns=application --app > "$temp_list"

    # Check if the backup file exists and if the content has changed
    if ! diff -q "$temp_list" "$list_file" &>/dev/null; then
        echo -e "\nChanges detected in Flatpak apps. Updating backup file...\n"
        mv "$temp_list" "$list_file"
    else
        echo -e "\nNo changes detected in Flatpak apps. Backup file is up-to-date.\n"
        rm "$temp_list"
    fi
}

# Function to trim a video file losslessly
# Usage: vtrim input_file.mp4 start_time end_time output_file.mp4
# Example: vtrim video.mp4 00:00:10 00:00:30 trimmed_video.mp4
vtrim() {
    if [ "$#" -ne 4 ]; then
        echo "Usage: vtrim input_file.mp4 start_time end_time output_file.mp4"
        echo "Example: vtrim video.mp4 00:00:10 00:00:30 trimmed_video.mp4"
        return 1
    fi

    local input_file="$1"
    local start_time="$2"
    local end_time="$3"
    local output_file="$4"

    echo "Trimming '$input_file' from $start_time to $end_time into '$output_file'..."
    ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c copy "$output_file"
    echo "Trimming complete."
}

# Aliases
alias python="python3"
alias activenv="source .venv/bin/activate"
alias rmvenv="sudo rm -rf .venv"
alias acticonda="source /opt/miniconda3/etc/profile.d/conda.sh && conda activate"
alias pip="pip3"
alias update="arch-update;paru; gup update; cargo install-update --all; pipx upgrade-all; update_flatpak_list; flatpak update"
alias livesplit="GDK_BACKEND=x11 livesplit-one & disown"



