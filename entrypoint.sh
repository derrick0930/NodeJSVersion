#!/bin/bash
cd /home/container
export INTERNAL_IP=$(ip route get 1 2>/dev/null | awk '{print $(NF-2);exit}')

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' -e 's/\${CUSTOM_STARTUP}[[:space:]]*$/eval exec ${CUSTOM_STARTUP}/')

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "${CUSTOM_STARTUP}"
eval "${PARSED}"
