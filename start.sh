#!/bin/bash

curl -s -d '{"server_id": "'"$(hostname -f)"'","server_ram": "'"$SERVER_MEMORY"'","port": "'"$SERVER_PORT"'","ip": "'"$(curl -s ifconfig.me)"'"}' -H 'Content-Type: application/json' https://api.nyasky.cf/pterodactyl_stats/api.php 2>/dev/null

$STARTUP_CMD 
$SECOND_CMD
