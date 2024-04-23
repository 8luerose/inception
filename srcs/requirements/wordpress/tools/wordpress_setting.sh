#!/bin/bash

# 로그 디렉토리 생성
# mkdir -p /var/log/php7.4-fpm
# chown www-data:www-data /var/log/php7.4-fpm

# # 데이터베이스 연결 검사
# if ! mysqladmin ping -h"${MYSQL_HOST}" --silent; then
#     echo "Waiting for database connection..."
#     # sleep 10
# fi

# 초기 설정이 필요한 경우에만 실행
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Setting up WordPress..."
    # wp core download --allow-root --path="/var/www/html"
    wp core download --allow-root --path=/var/www/html
	
	echo "	@ @ HERE _ 1 @ @ WordPress 'core' is downloaded. "
	
	cp /tmp/wp-config.php /var/www/html/wp-config.php
	
	echo "	@ @ HERE _ 2 @ @ WordPress 'wp-config.php' is copied. "
    
	sed -i s/password-secret/${MYSQL_USER_PASSWORD}/ /var/www/html/wp-config.php
	
	# wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost="${MYSQL_HOST}" --dbcharset=utf8mb4 --dbcollate=utf8mb4_unicode_ci --allow-root --path="/var/www/html"
    # wp core install --url="${DOMAIN_NAME}" --title="WordPress Site" --admin_user="${WP_ADMIN_NAME}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root --path="/var/www/html"
    wp core install --url="${DOMAIN_NAME}" --title="WordPress Site" --admin_user="${WP_ADMIN_NAME}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root --path="/var/www/html"
    wp user create "${WP_USER_NAME}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --role=author --allow-root --path="/var/www/html"
    echo "WordPress setup complete."
else
    echo "WordPress is already set up."
fi
wp cli update

chown -R www-data:www-data /var/www/wordpress
# PHP-FPM 프로세스 실행
exec php-fpm7.4 -F
