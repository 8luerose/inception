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

	mkdir -p /var/www/html

	cd /var/www/html

	rm -rf *
    # wp core download --allow-root --path="/var/www/html"
    wp core download --allow-root
    # wp core download --allow-root
	
	echo "	--- WordPress 'core' is downloaded. "
	
	# cp /tmp/wp-config.php /var/www/html/wp-config.php
	
	echo "	@ @ HERE _ 2 @ @ WordPress 'wp-config.php' is copied. "
    
	# sed -i s/password-secret/${MYSQL_USER_PASSWORD}/ /var/www/html/wp-config.php
	# sed -i "s/'password_here'/'${WORDPRESS_DB_PASSWORD}'/g" ${WP_PATH}${WP_FILE}
	# sed -i "s/'password-secret'/'${MYSQL_USER_PASSWORD}'/g" /var/www/html/wp-config.php
	
	# wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost="${MYSQL_HOST}" --dbcharset=utf8mb4 --dbcollate=utf8mb4_unicode_ci --allow-root --path="/var/www/html"
	
	# 진님표
	wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost="${MYSQL_HOST}" --dbcharset=utf8mb4 --dbcollate=utf8mb4_unicode_ci --allow-root
    # wp core install --url="${DOMAIN_NAME}" --title="WordPress Site" --admin_user="${WP_ADMIN_NAME}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root --path="/var/www/html"
    # wp core install --allow-root --url="${DOMAIN_NAME}" --title="WordPress Title" --admin_user="${WP_ADMIN_NAME}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root --path="/var/www/html"
    
	#진님표
	wp core install --allow-root --url="${DOMAIN_NAME}" --title="WordPress Title" --admin_user="${WP_ADMIN_NAME}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root
    # wp user create --allow-root "${WP_USER_NAME}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --role=author --path="/var/www/html"
    wp user create --allow-root "${WP_USER_NAME}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --role=author

	wp theme install astra --activate --allow-root

    echo "WordPress setup complete."
else
    echo "WordPress is already set up."
fi

# sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

wp cli update



chown -R www-data:www-data /var/www/html/
# PHP-FPM 프로세스 실행
exec php-fpm7.4 -F
