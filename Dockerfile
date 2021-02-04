FROM debian:buster

WORKDIR /

RUN mkdir -p /var/www/public/

RUN apt-get update && \
	apt-get upgrade -y

RUN apt-get install -y \
	vim \
	tmux \
	wget

RUN apt-get install -y \
	nginx \
	mariadb-server

RUN apt-get install -y \
	php \
	php-cgi \
	php-fpm \
	php-mysql \
    php-curl \
	php-gd \
	php-intl \
	php-mbstring \
	php-soap \
	php-xml \
	php-xmlrpc \
	php-zip
	
#################
# nginx configs #
#################
COPY ./srcs/conf.d /etc/nginx/conf.d
COPY ./srcs/nginx.conf /etc/nginx/nginx.conf

#########
# mysql #
#########
RUN service mysql start \
    && mysql -u root \
	&& mysql --execute="CREATE DATABASE wp_base; \
	GRANT ALL PRIVILEGES ON wp_base.* TO 'root'@'localhost'; \
	FLUSH PRIVILEGES; \
	UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='root';"

#############
# wordpress #
#############
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz && \
	mv wordpress/ /var/www/public/wordpress
COPY ./srcs/wp-config.php /var/www/public/wordpress
RUN chown -R www-data:www-data /var/www/public/wordpress && \
	find /var/www/public/wordpress/ -type d -exec chmod 775 {} + && \
	find /var/www/public/wordpress/ -type f -exec chmod 664 {} + && \
	chmod 660 /var/www/public/wordpress/wp-config.php

##############
# phpmyadmin #
##############
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz
RUN tar -xzvf phpMyAdmin-5.0.2-english.tar.gz && \
	mv phpMyAdmin-5.0.2-english/ /var/www/public/phpmyadmin
RUN chown -R www-data:www-data /var/www/public/phpmyadmin
COPY ./srcs/config.inc.php /var/www/public/phpmyadmin

#############
# ssl stuff #
#############
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=ru/ST=Moscow/L=Moscow/O=no/OU=no/CN=public/" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt
#RUN openssl dhparam -out /etc/nginx/dhparam.pem 4096

################
#   scripts    #
################
COPY ./srcs/autoindex_switch.sh .
COPY ./srcs/activate_services.sh .

EXPOSE 80 443

CMD ["bash", "activate_services.sh"]
