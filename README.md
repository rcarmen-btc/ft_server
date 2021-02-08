# ft_server
```bash
docker build -t ft_server .
docker run -dt --name ft_server --rm -p 80:80 -p 443:443 ft_server
docker exec -it ft_server bash
```
OR
```bash
docker build -t ft_server .
docker run -it --name ft_server --rm -p 80:80 -p 443:443 ft_server
```
