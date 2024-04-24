#!/bin/bash

chown -R mysql:mysql /var/lib/mysql

service mariadb start
echo " --- service mariadb starting... --- "

sleep 1

echo " --- Permission setting... --- "

echo "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME ;" > init.sql
echo "CREATE USER IF NOT EXISTS '$DATABASE_USER'@'%' IDENTIFIED BY '$DATABASE_PASSWORD' ;" >> init.sql
echo "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%' ;" >> init.sql
echo "FLUSH PRIVILEGES;" >> init.sql

mysql < init.sql

echo " --- Permission setting complete! --- "

sleep 1

service mariadb stop
echo " --- service mariadb stoping... --- "

sleep 1

echo " --- FOREGROUND SETTING... --- "
mariadbd #포그라운드로 설정 