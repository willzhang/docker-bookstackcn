#!/bin/bash
#docker rm -f mysql
docker run -itd --name mysql --restart always \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=bookstack \
  -e MYSQL_DATABASE=bookstack \
  -e MYSQL_USER=bookstack \
  -e MYSQL_PASSWORD=bookstack \
  -v /data/mysql:/var/lib/mysql \
  mysql --default-authentication-plugin=mysql_native_password
