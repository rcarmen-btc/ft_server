#!/bin/bash

cp /var/www/public/autoindex/nginx_autoindex_off.conf /etc/nginx/sites-available/public
service nginx restart
echo "autoindex off"
