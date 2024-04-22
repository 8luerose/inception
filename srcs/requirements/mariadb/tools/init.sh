#!/bin/bash
set -e

# 종료 시 모든 프로세스 정리
pkill mysqld || true

# 기존 데이터베이스 파일 제거
# rm -rf /var/lib/mysql/*

# 데이터베이스 초기 설치 확인
# if [ ! -d /var/lib/mysql/mysql ]; then
if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
    echo "Database not installed, initializing..."
    mariadb-install-db

    # # MariaDB 서버 백그라운드 시작
    # mysqld_safe --skip-networking &

    # # MariaDB 서버가 응답할 때까지 대기
    # while ! mariadb-admin ping --silent; do
    #     sleep 1
    # done
	service mariadb start

    # root 사용자 비밀번호 설정
    mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"

    # 사용자와 데이터베이스 생성
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    # MariaDB 서버 종료
    # mariadb-admin shutdown
	service mariadb stop
else
    echo "Database already installed."
fi

mysqld --user=root
