#!/usr/bin/env bash

# Define color codes for CPU usage levels in tmux status bar
COLOR_CPU_LOW="#[fg=#00ff00, bg=default]"
COLOR_CPU_MODERATE="#[fg=#ffff00, bg=default]"
COLOR_CPU_HIGH="#[fg=#ff0000, bg=default]"

# Get current CPU usage
cpu_usage_total=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Display CPU usage with color coding based on thresholds
if (($(echo "$cpu_usage_total >= 80" | bc -l))); then
  echo "${COLOR_CPU_HIGH} ${cpu_usage_total}%"
elif (($(echo "$cpu_usage_total >= 60" | bc -l))); then
  echo "${COLOR_CPU_MODERATE} ${cpu_usage_total}%"
elif (($(echo "$cpu_usage_total >= 40" | bc -l))); then
  echo "${COLOR_CPU_MODERATE} ${cpu_usage_total}%"
elif (($(echo "$cpu_usage_total >= 20" | bc -l))); then
  echo "${COLOR_CPU_LOW} ${cpu_usage_total}%"
else
  echo "${COLOR_CPU_LOW} ${cpu_usage_total}%"
fi
