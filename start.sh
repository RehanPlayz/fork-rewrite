#!/bin/bash
echo "==========Server Details=========="
echo "Server ID: $(hostname | cut -d '-' -f 1)"
echo "Server RAM: $SERVER_MEMORY MB"
echo "Server IP: $SERVER_IP"
echo "Driver Port: $SERVER_PORT"
echo "HTTP Port: $HTTP_PORT"
echo "Cluster Port: $CLUSTER_PORT"
echo "Admin Password: $ADMIN_PASSWORD"
echo "==========Server Details=========="

rethinkdb -d /home/container --bind 0.0.0.0 --bind-http 0.0.0.0 --bind-cluster 0.0.0.0 --bind-driver 0.0.0.0 --http-port $HTTP_PORT --driver-port $SERVER_PORT --initial-password $ADMIN_PASSWORD --cluster-port $CLUSTER_PORT --log-file rethink.log --cache-size auto 
