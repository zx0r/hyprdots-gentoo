#!/usr/bin/env bash

# Enable strict error checking
set -euo pipefail

IFS=$'\n\t'
#scrDir=$(dirname "$(realpath "$0")")

# Auto-detect GPU and set flags
detect_gpu() {
  if lspci -nn | grep -E "(VGA|3D)" | grep -q "10de"; then
    primary_gpu="NVIDIA $(nvidia-smi --query-gpu=name --format=csv,noheader,nounits)"
    nvidia_GPU
  elif lspci -nn | grep -E "(VGA|3D)" | grep -q "1002"; then
    gpu=$(lspci | grep -i "VGA" | grep AMD | grep "Navi" | awk -F'[][]' '{print $2" "$3}')
    primary_gpu="$gpu"
    amd_GPU
  elif lspci -nn | grep -E "(VGA|3D)" | grep -q "8086"; then
    primary_gpu="Intel $(lspci | grep -i vga | grep Intel | cut -d ':' -f3)"
    general_query
  fi
}

# AMD GPU specific function
amd_GPU() {
  gpu=$(lspci | grep -i "VGA" | grep AMD | grep "Navi" | awk -F'[][]' '{print $2" "$3}')
  gpu_info=$(sensors amdgpu-pci-0300)
  temperature=$(echo "$gpu_info" | grep 'edge' | awk '{print $2}' | tr -d '+°C' | cut -d'.' -f1)
  power_usage=$(echo "$gpu_info" | grep 'PPT' | awk '{print $2}' | tr -d 'W')
  #core_clock=$(echo "$gpu_info" | grep 'sclk' | awk '{print $2}' | tr -d 'MHz')
  gpu_load=$(cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null || echo "0")
  utilization=$gpu_load
}

# NVIDIA GPU specific function
nvidia_GPU() {
  if ${tired} && [[ $(cat /sys/bus/pci/devices/0000:"${nvidia_address}"/power/runtime_status) == *"suspend"* ]]; then
    printf '{"text":"󰤂", "tooltip":"%s ⏾ Suspended mode"}' "${primary_gpu}"
    exit
  fi

  gpu_info=$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,clocks.current.graphics,clocks.max.graphics,power.draw,power.limit --format=csv,noheader,nounits)
  IFS=',' read -ra gpu_data <<<"${gpu_info}"
  temperature="${gpu_data[0]// /}"
  utilization="${gpu_data[1]// /}"
  #current_clock_speed="${gpu_data[2]// /}"
  # max_clock_speed="${gpu_data[3]// /}"
  power_usage="${gpu_data[4]// /}"
  #power_limit="${gpu_data[5]// /}"
}

map_floor() {

  # From the depths of the string, words arise,
  # Keys in pairs, a treasure in disguise.
  IFS=', ' read -r -a pairs <<<"$1"

  # If the final token stands alone and bold,
  # Declare it the default, its worth untold.
  if [[ ${pairs[-1]} != *":"* ]]; then
    def_val="${pairs[-1]}"
    unset 'pairs[${#pairs[@]}-1]'
  fi

  # Scans the map, a peak it seeks,
  # The highest passed, the value speaks.
  for pair in "${pairs[@]}"; do
    IFS=':' read -r key value <<<"$pair"

    # Behold! Thou holds the secrets they seek,
    # Declare it and silence the whispers unique.
    if awk -v num="$2" -v k="$key" 'BEGIN { exit !(num > k) }'; then
      echo "$value"
      return
    fi
  done

  # On this lonely shore, where silence dwells
  # Even the waves, echoes words unheard
  [ -n "$def_val" ] && echo "$def_val" || echo " "
}

# generate emoji and icon based on temperature and utilization
get_icons() {
  # key-value pairs of temperature and utilization levels
  temp_lv="85:&🌋, 65:&🔥, 45:&☁️, &❄️"
  util_lv="90:, 60:󰓅, 30:󰾅, 󰾆"

  # return comma separated emojis/icons
  icons=$(map_floor "$temp_lv" "$1" | sed "s/&/,/")
  icons="$icons,$(map_floor "$util_lv" "$2")"
  echo "$icons"
}

generate_json() {
  icons=$(get_icons "$temperature" "$utilization")
  thermo=$(echo "$icons" | awk -F, '{print $1}')
  emoji=$(echo "$icons" | awk -F, '{print $2}')
  #speedo=$(echo $icons | awk -F, '{print $3}')

  local json="{\"text\":\"GPU ${temperature}°C\", \"tooltip\":\"$gpu\n${thermo} Temperature: ${temperature}°C ${emoji}\n󱪉 Power Usage: ${power_usage}W\"}"

  json="${json}\"}"
  echo "${json}"
}

# Main execution
detect_gpu
generate_json
