#!/bin/bash

# 초기 설정이 필요한 경우에만 실행
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Setting up WordPress..."
    # wp-cli 도구를 사용하여 WordPress를 다운로드하고 설치합니다.
    wp core download --allow-root --path="/var/www/html"
    # wp-config.php 파일을 기본 샘플에서 생성
    wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --dbhost=${DB_HOST} --dbcharset=utf8mb4 --dbcollate=utf8mb4_unicode_ci --allow-root --path="/var/www/html"
    # WordPress를 설치
    wp core install --url="${DOMAIN_NAME}" --title="${SITE_TITLE}" --admin_user="${ADMIN_USER}" --admin_password="${ADMIN_PASSWORD}" --admin_email="${ADMIN_EMAIL}" --skip-email --allow-root --path="/var/www/html"
    # 추가적인 사용자를 생성
    wp user create ${USER_NAME} ${USER_EMAIL} --user_pass=${USER_PASSWORD} --role=author --allow-root --path="/var/www/html"
    echo "WordPress setup complete."
else
	echo "WordPress is already set up."

fi

# PHP-FPM 프로세스 실행
exec php-fpm8.0 -F
