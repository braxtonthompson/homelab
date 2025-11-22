#!/usr/bin/env bash
set -euo pipefail

CHECK_URL="https://ifconfig.io/ip"
CURL_IMAGE="curlimages/curl:latest"

printf "%-30s %-20s\n" "Container" "External_IP"
printf "%-30s %-20s\n" "---------" "-----------"

# Loop through all running containers
while read -r id name; do
  ip=$(docker run --rm --network "container:${id}" "$CURL_IMAGE" -s "$CHECK_URL" 2>/dev/null || echo "N/A")
  printf "%-30s %-20s\n" "$name" "$ip"
done < <(docker ps --format '{{.ID}} {{.Names}}')

