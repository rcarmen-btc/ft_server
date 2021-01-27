FROM debian:buster

RUN mkdir -p /usr/src/app/

RUN apt update -y && \
	apt install nginx -y \

WORKDIR /usr/src/app/

COPY . /usr/src/app/ 

EXPOSE 80 443     

CMD ["nginx", "-g", "daemon off;"]

#CMD ["", ]
