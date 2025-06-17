#!/usr/bin/bash

# Get current battery percentage
batteryPercentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Get battery status (Charging or Discharging)
batteryStatus=$(cat /sys/class/power_supply/BAT0/status)

# Define the battery icons for each 10% segment
batteryIcons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
chargingIcon="󰂄"

# Calculate the index for the icon array
iconIndex=$((batteryPercentage / 10))

# Get the corresponding icon
currentIcon=${batteryIcons[iconIndex]}

# Check if the battery is charging
if [ "$batteryStatus" = "Charging" ]; then
	currentIcon="$chargingIcon"
fi

# Output the battery percentage and icon
echo "$batteryPercentage% $currentIcon"