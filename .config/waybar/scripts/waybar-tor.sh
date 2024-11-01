#!/usr/bin/env bash

check_tor() {
  if curl -s -m 5 -L "https://check.torproject.org/" | grep -q 'Congratulations'; then
    printf '{"text": " ", "class": "custom-tor", "alt": "connected", "tooltip": "Tor Connected"}'
  else
    printf '{"text": " ", "class": "custom-tor", "alt": "disconnected", "tooltip": "Tor Disconnected"}'
  fi
}

check_ip() {
  local api_endpoints=(
    "https://ipinfo.io"
    "https://ipapi.co/json"
  )

  for endpoint in "${api_endpoints[@]}"; do
    if info=$(curl -s -m 5 "$endpoint"); then
      if echo "$info" | jq -e . >/dev/null 2>&1; then
        echo "$info" | jq -r '[.ip, .city, .region, .country, .hostname] | join(" | ")'
        return 0
      fi
    fi
  done
  echo "IP info unavailable"
  return 1
}

main() {
  case "$1" in
  check)
    check_tor
    ;;
  ip)
    check_ip
    ;;
  *)
    echo "Usage: $0 {check|ip}"
    exit 1
    ;;
  esac
}

main "$@"
