FROM debian:buster

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
		nginx \
		php \
		php-fpm \
		php-mysql \
		mariadb-server \
		tree \
		vim \
		less \
		wget

RUN apt-get -y install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

RUN mkdir /var/www/home && \
	chown -R $USER:$USER /var/www/home

COPY ./srcs/activate_services.sh .
COPY ./srcs/echo_hi.sh .
COPY ./srcs/wrapper_script.sh .
RUN chmod ugo+x activate_services.sh
RUN chmod ugo+x echo_hi.sh
RUN chmod ugo+x wrapper_script.sh

COPY ./srcs/index.php /var/www/home/

COPY ./srcs/nginx.conf /etc/nginx/sites-available/home

RUN ln -s /etc/nginx/sites-available/home /etc/nginx/sites-enabled/ && \
	rm -rf /etc/nginx/sites-enabled/default

WORKDIR .

EXPOSE 80 443 

CMD ["./wrapper_script.sh"]

