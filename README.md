# ft_server

docker build ft_server .
docker run -dt --name ft_server -p 80:80 -p 443:443 ft_server
docker exec -it ft_server bash

OR

docker build ft_server .
docker run -it --name ft_server -p 80:80 -p 443:443 ft_server
docker exec -it ft_server bash
