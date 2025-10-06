#!/bin/bash

# Text color(s) for tempatures and text :thumbs_up:
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"
BOLD="\033[1m"

while true; do
  clear
  echo -e "${BOLD}=== Disclaimer: Temperatures shown are software-reported & approximated ===${RESET}\n"

  for z in /sys/class/thermal/thermal_zone*; do
    t=$(cat "$z/type")
    temp=$(awk '{ printf "%.1f", $1 / 1000 }' "$z/temp")

# Text color based off tempature code :clock:
    if (( $(echo "$temp < 50" | bc -l) )); then
      color=$GREEN
    elif (( $(echo "$temp < 70" | bc -l) )); then
      color=$YELLOW
    else
      color=$RED
    fi

# Print everything all formated :thumbs_up:
    printf "%-20s %-30s %b%6s°C%b\n" "$t" "$z" "$color" "$temp" "$RESET"
  done

  sleep 2
done
