#!/usr/bin/env python3
import os
from sys import stdout

# Define our input and output paths
CSS_PATH:str = os.path.expanduser("~/.config/waybar/colors.css")
OUTPUT_PATH:str = os.path.expanduser("~/.cache/sequences")

# Map which ANSI slot gets which Matugen color name
# 1. The 16-color ANSI Palette (0-15)
ansi_palette: dict[str, str] = {
    "0": "surface",                   # Black / Background
    "1": "error_container",           # Dark Red
    "2": "secondary_container",       # Dark Teal/Green hue
    "3": "outline_variant",           # Dark Yellow/Ochre hue
    "4": "primary_container",         # Dark Blue
    "5": "tertiary_container",        # Dark Magenta/Purple
    "6": "surface_bright",            # Dark Cyan
    "7": "on_surface_variant",        # Light Gray / Muted White
    "8": "surface_container_highest", # Bright Black / Selection BG
    "9": "error",                     # Bright Red
    "10": "secondary",                # Bright Teal/Green hue
    "11": "outline",                  # Bright Yellow/Ochre hue
    "12": "primary",                  # Bright Blue
    "13": "tertiary",                 # Bright Magenta
    "14": "inverse_primary",          # Bright Cyan
    "15": "on_surface"                # Pure White / Bright Foreground
}
# 2. Terminal feature overrides (uses different escape codes)
terminal_features: dict[str, str] = {
    "10": "on_surface",  # Default Text Foreground
    "11": "surface",     # Default Window Background
    "12": "primary",     # Text Cursor Color (Makes it pop!)
    "13": "on_surface",  # Mouse Pointer
    "17": "on_surface",  # Highlight Text Foreground
    "19": "surface_variant" # Highlight Background Box
}

# Function to extract colors from the input CSS file
def extract_colors():
    colors:dict[str, str] = {}
    # Error out if file not found
    if not os.path.exists(CSS_PATH):
        raise FileNotFoundError(f"Could not find {CSS_PATH}")

    # Extract colors from the CSS file
    with open(CSS_PATH, "r") as f:
        for line in f:
            if "@define-color" in line:
                parts: list[str] = line.strip().split()
                if len(parts) >= 3:
                    name: str = parts[1]
                    hex_val: str = parts[2].replace("#", "").replace(";", "")
                    colors[name] = hex_val
    return colors

# Main function
def main():
    # Error out if no colors were extracted
    css_colors:dict[str, str] = extract_colors()
    if not css_colors:
        raise ValueError("No colors were extracted")

    # Build the binary escape sequence string
    sequence_bytes:bytearray = bytearray()
    
    # Process standard 0-15 colors (OSC 4) - Using "ansi_hex"
    for slot, matugen_name in ansi_palette.items():
        if matugen_name in css_colors:
            ansi_hex:str = css_colors[matugen_name]
            ansi_block:str = f"\x1b]4;{slot};#{ansi_hex}\x07"
            sequence_bytes.extend(ansi_block.encode("utf-8"))

    # Process special feature colors (OSC 10, 11, 12, etc.) - Using "feature_hex"
    for cmd, matugen_name in terminal_features.items():
        if matugen_name in css_colors:
            feature_hex:str = css_colors[matugen_name]
            feature_block:str = f"\x1b]{cmd};#{feature_hex}\x07"
            sequence_bytes.extend(feature_block.encode("utf-8"))

    # Save the absolute binary sequences file
    with open(OUTPUT_PATH, "wb") as f:
        _ =f.write(sequence_bytes)
    
    # Push the binary sequence live to the active terminal screen
    _ = stdout.buffer.write(sequence_bytes)
    _ = stdout.flush()

    # Print the 'wal --preview' style block display:
    # Header
    print("\n  \x1b[1mMatugen Palette Preview\x1b[0m")
    print("  " + "—" * 32)
    # Row 1: Normal Colors (0-7)
    row1: str = "  "
    for i in range(8):
        row1 += f"\x1b[48;5;{i}m      \x1b[0m"
    print(row1)
    # Row 2: Bright Colors (8-15)
    row2: str = "  "
    for i in range(8, 16):
        row2 += f"\x1b[48;5;{i}m      \x1b[0m"
    print(row2)
    # Footer
    print("  " + "—" * 32 + "\n")

# Execution
if __name__ == "__main__":
    main()