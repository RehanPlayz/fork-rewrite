#!/bin/ash
echo "==========Server Details=========="
echo "Server RAM: $SERVER_MEMORY MB"
echo "Server IP: $SERVER_IP"
echo "Server Port: $SERVER_PORT"
echo "==========Server Details=========="

echo "Starting PHP-FPM..."
/usr/sbin/php-fpm7 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize

echo "Starting Nginx..."
/usr/sbin/nginx -c /home/container/nginx/nginx.conf
