#!/usr/bin/env bash

# Define color codes for memory usage levels in tmux status bar
COLOR_MEM_LOW="#[fg=#00ff00, bg=default]"
COLOR_MEM_MODERATE="#[fg=#ffff00, bg=default]"
COLOR_MEM_HIGH="#[fg=#ff0000, bg=default]"

# Calculate memory usage percentage
mem_usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

# Display memory usage with color coding based on thresholds
if ((mem_usage >= 80)); then
  echo "${COLOR_MEM_HIGH}﬙ ${mem_usage}%"
elif ((mem_usage >= 60)); then
  echo "${COLOR_MEM_MODERATE}﬙ ${mem_usage}%"
elif ((mem_usage >= 40)); then
  echo "${COLOR_MEM_MODERATE}﬙ ${mem_usage}%"
elif ((mem_usage >= 20)); then
  echo "${COLOR_MEM_LOW}﬙ ${mem_usage}%"
else
  echo "${COLOR_MEM_LOW}﬙ ${mem_usage}%"
fi
