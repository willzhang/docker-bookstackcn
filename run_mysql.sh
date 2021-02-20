#!/bin/bash
docker run -d --name mysql \
  --restart always \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e MYSQL_DATABASE=bookstack \
  -e MYSQL_USER=bookstack \
  -e MYSQL_PASSWORD=bookstack123 \
  -v mysql:/var/lib/mysql \
  mysql:8.0.23 --default-authentication-plugin=mysql_native_password
