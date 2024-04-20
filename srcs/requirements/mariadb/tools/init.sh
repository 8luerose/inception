#!/bin/bash
set -e

# 데이터베이스와 사용자 설정
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql
    service mariadb start
	mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -u root -e "FLUSH PRIVILEGES;"
	# 현재 설정된 사용자와 호스트를 출력하여 확인
    mysql -u root -e "SELECT host, user FROM mysql.user WHERE user='${MYSQL_USER}';"
else
	echo "Database is already initialized"
fi


# 데이터베이스 서버 실행
exec mysqld_safe
