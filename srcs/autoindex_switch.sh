#!/bin/bash

if [ -f /etc/nginx/conf.d/default.conf ]; then 
	mv etc/nginx/conf.d/default.conf etc/nginx/conf.d/default
	mv etc/nginx/conf.d/default_autoindex_off etc/nginx/conf.d/default_autoindex_off.conf
	echo "[ ok ] Autoindex [ off ]"
elif [ -f /etc/nginx/conf.d/default_autoindex_off.conf ]; then 
	mv etc/nginx/conf.d/default_autoindex_off.conf etc/nginx/conf.d/default_autoindex_off
	mv etc/nginx/conf.d/default etc/nginx/conf.d/default.conf
	echo "[ ok ] Autoindex [ on ]"
else
	echo "[ fail ] Error!!!"
fi


service nginx restart
