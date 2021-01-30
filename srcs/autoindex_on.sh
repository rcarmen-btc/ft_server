#!/bin/bash

cp /var/www/public/autoindex/nginx.conf /etc/nginx/sites-available/public
service nginx restart
echo "autoindex on"
