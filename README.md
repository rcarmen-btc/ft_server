# ft_server

Веб-сервер в одном Docker-контейнере: Nginx, WordPress, phpMyAdmin и MariaDB на Debian Buster. Учебный проект [Школы 21](https://21-school.ru).

*English: a single-container web server (Nginx + WordPress + phpMyAdmin + MariaDB on Debian) built with a Dockerfile. School 21 project.*

## Что внутри

- **Nginx**: порт 80 перенаправляет на HTTPS, на порту 443 самоподписанный сертификат (создаётся при сборке образа), PHP обрабатывает через PHP-FPM 7.3.
- **WordPress** по адресу `/wordpress`, **phpMyAdmin** 5.0.2 по адресу `/phpmyadmin`; корень сайта — `/var/www/public`.
- **MariaDB** с базой `wp_base`.
- **Переключатель autoindex**: `autoindex_switch.sh` включает и выключает листинг каталога, подменяя конфиг Nginx, и перезапускает Nginx.
- Сервисы запускает `srcs/activate_services.sh`.

Это учебная сборка: у пользователя БД нет пароля, ключи WordPress не заданы. Для настоящего сервера так делать нельзя.

## Как запустить

```bash
docker build -t ft_server .
docker run -it --name ft_server --rm -p 80:80 -p 443:443 ft_server
```

Откройте `https://localhost/wordpress` или `https://localhost/phpmyadmin` (браузер предупредит о самоподписанном сертификате).

Чтобы запустить в фоне и зайти внутрь:

```bash
docker run -dt --name ft_server --rm -p 80:80 -p 443:443 ft_server
docker exec -it ft_server bash
```

Переключить autoindex (внутри контейнера, из корня `/`): `bash autoindex_switch.sh`.

## Полезные команды Docker

```bash
docker image ls / docker rmi <образ>        # образы
docker ps [-a] / docker rm <контейнер>      # контейнеры
docker inspect <контейнер>
```

## Стек

Docker, Debian Buster, Nginx, PHP-FPM, WordPress, phpMyAdmin, MariaDB, OpenSSL, Bash.
