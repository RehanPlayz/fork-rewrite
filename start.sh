#!/bin/bash
echo "==========Server Details=========="
echo "Server ID: $(hostname | cut -d '-' -f 1)"
echo "Server RAM: $SERVER_MEMORY MB"
echo "Server IP: $SERVER_IP"
echo "Server Port: $SERVER_PORT"
echo "==========Server Details=========="

$STARTUP_CMD 
$SECOND_CMD
