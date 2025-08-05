#!/usr/bin/env bash

alias python="python3"
alias activenv="source .venv/bin/activate"
alias rmvenv="sudo rm -rf .venv"
alias pip="pip3"
alias update="paru; gup update; cargo install-update --all; pipx upgrade-all; flatpak update"
alias livesplit="GDK_BACKEND=x11 livesplit-one & disown"

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

