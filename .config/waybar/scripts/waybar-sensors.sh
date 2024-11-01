#!/bin/sh

# Initialize variables
cpu_temp="0"
gpu_temp="0"
gpu_draw="0"
nvme_1_temp="0"
nvme_2_temp="0"
mem_free="0G"

if [ "$(cat /sys/class/drm/card0-DP-3/dpms)" = "On" ]; then
  # CPU temperature
  cpu_temp=$(sensors k10temp-pci-00c3 | awk '/Tccd1/ {print int($2)}')

  # GPU temperature and power
  gpu_info=$(sensors amdgpu-pci-0300)
  gpu_temp=$(echo "$gpu_info" | awk '/edge/ {print int($2)}')
  gpu_draw=$(echo "$gpu_info" | awk '/PPT/ {print int($2)}')

  # NVMe temperatures
  nvme_1_temp=$(sensors nvme-pci-1600 | awk '/Sensor 2/ {print int($3)}')
  nvme_2_temp=$(sensors nvme-pci-0400 | awk '/Sensor 2/ {print int($3)}')

  # Memory free
  mem_free=$(free -g | awk '/^Mem:/ {print $4"G"}')
fi

echo -n "{\"text\": \"<span color='#aaaaaa'>CPU $cpu_temp°C</span> GPU <span color='#aaaaaa'>$gpu_temp°C</span> [<span color='#aaaaaa'>$gpu_draw W</span>] SSDs <span color='#aaaaaa'>$nvme_1_temp°C $nvme_2_temp°C</span> RAM <span color='#aaaaaa'>$mem_free</span>\", \"tooltip\": \"\", \"alt\": \"\", \"class\": \"\" }"
