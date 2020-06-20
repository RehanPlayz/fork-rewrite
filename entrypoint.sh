#!/bin/bash
sleep 2

cd /home/container
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Stats
curl -s -d '{"server_id": "'"$(hostname -f)"'","server_ram": "'"$SERVER_MEMORY"'","port": "'"$SERVER_PORT"'","ip": "'"$(curl -s ifconfig.me)"'"}' -H 'Content-Type: application/json' https://api.nyasky.cf/pterodactyl_stats/api.php 2>/dev/null

# Run the Server
bash /start.sh "${MODIFIED_STARTUP}"
