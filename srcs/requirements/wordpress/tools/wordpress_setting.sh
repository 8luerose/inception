#!/bin/bash

# 로그 디렉토리 생성
# mkdir -p /var/log/php7.4-fpm
# chown www-data:www-data /var/log/php7.4-fpm

# # 데이터베이스 연결 검사
# if ! mysqladmin ping -h"${DATABASE_HOST}" --silent; then
#     echo "Waiting for database connection..."
#     # sleep 10
# fi

# 초기 설정이 필요한 경우에만 실행
# echo " --- find /var/www/html/wp-config.php --- "
# if [ ! -f "/var/www/html/wp-config.php" ]; then
#     echo "Setting up WordPress..."

# 	mkdir -p /var/www/html

# 	cd /var/www/html

# 	rm -rf *
#     # wp core download --allow-root --path="/var/www/html"
#     wp core download --allow-root
#     # wp core download --allow-root
	
# 	echo "	--- WordPress 'core' is downloaded. "
	
# 	# cp /tmp/wp-config.php /var/www/html/wp-config.php
	
# 	# echo "	--- WordPress 'wp-config.php' is copied. "
    
# 	# sed -i s/password-secret/${DATABASE_USER_PASSWORD}/ /var/www/html/wp-config.php
# 	# sed -i "s/'password_here'/'${WORDPRESS_DB_PASSWORD}'/g" ${WP_PATH}${WP_FILE}
# 	# sed -i "s/'password-secret'/'${DATABASE_USER_PASSWORD}'/g" /var/www/html/wp-config.php
	
# 	# wp config create --dbname="${DATABASE_NAME}" --dbuser="${DATABASE_USER}" --dbpass="${DATABASE_PASSWORD}" --dbhost="${DATABASE_HOST}" --dbcharset=utf8mb4 --dbcollate=utf8mb4_unicode_ci --allow-root --path="/var/www/html"
	
# 	# 진님표
# 	wp config create --dbname="${DATABASE_NAME}" --dbuser="${DATABASE_USER}" --dbpass="${DATABASE_PASSWORD}" --dbhost="${DATABASE_HOST}" --allow-root
#     # wp core install --url="${DOMAIN_NAME}" --title="WordPress Site" --admin_user="${WORDPRESS_ADMIN_NAME}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" --admin_email="${WORDPRESS_ADMIN_EMAIL}" --skip-email --allow-root --path="/var/www/html"
#     # wp core install --allow-root --url="${DOMAIN_NAME}" --title="WordPress Title" --admin_user="${WORDPRESS_ADMIN_NAME}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" --admin_email="${WORDPRESS_ADMIN_EMAIL}" --skip-email --allow-root --path="/var/www/html"
    
# 	echo "	--- WordPress 'config' is created. "

# 	#진님표
# 	wp core install --url="${DOMAIN_NAME}" --title="WordPress Title" --admin_user="${WORDPRESS_ADMIN_NAME}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" --admin_email="${WORDPRESS_ADMIN_EMAIL}" --skip-email --allow-root
#     # wp user create --allow-root "${WORDPRESS_USER_NAME}" "${WORDPRESS_USER_EMAIL}" --user_pass="${WORDPRESS_USER_PASSWORD}" --role=author --path="/var/www/html"
    
# 	echo "	--- WordPress 'core' is installed. "

# 	wp user create "${WORDPRESS_USER_NAME}" "${WORDPRESS_USER_EMAIL}" --user_pass="${WORDPRESS_USER_PASSWORD}" --role=author --allow-root 


# 	echo " --- WordPress 'user' is created. "

# 	# wp theme install astra --activate --allow-root --path="/var/www/html"
# 	wp theme install astra --activate --allow-root

# 	echo " --- WordPress 'theme' is installed. "

#     echo "WordPress setup complete."
# else
#     echo "WordPress is already set up."
# fi

# sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# # wp cli update



# # chown -R www-data:www-data /var/www/html/
# # PHP-FPM 프로세스 실행
# exec php-fpm7.4 -F


# echo " --- find /var/www/html/wp-config.php --- "

echo "Setting up WordPress..."

mkdir -p /var/www/html

cd /var/www/html

rm -rf *
# wp core download --allow-root --path="/var/www/html"
wp core download --allow-root
# wp core download --allow-root

echo "	--- WordPress 'core' is downloaded. "

# cp /tmp/wp-config.php /var/www/html/wp-config.php

# echo "	--- WordPress 'wp-config.php' is copied. "

# sed -i s/password-secret/${DATABASE_USER_PASSWORD}/ /var/www/html/wp-config.php
# sed -i "s/'password_here'/'${WORDPRESS_DB_PASSWORD}'/g" ${WP_PATH}${WP_FILE}
# sed -i "s/'password-secret'/'${DATABASE_USER_PASSWORD}'/g" /var/www/html/wp-config.php

# wp config create --dbname="${DATABASE_NAME}" --dbuser="${DATABASE_USER}" --dbpass="${DATABASE_PASSWORD}" --dbhost="${DATABASE_HOST}" --dbcharset=utf8mb4 --dbcollate=utf8mb4_unicode_ci --allow-root --path="/var/www/html"

# 진님표
wp config create --dbname="${DATABASE_NAME}" --dbuser="${DATABASE_USER}" --dbpass="${DATABASE_PASSWORD}" --dbhost="${DATABASE_HOST}" --allow-root
# wp core install --url="${DOMAIN_NAME}" --title="WordPress Site" --admin_user="${WORDPRESS_ADMIN_NAME}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" --admin_email="${WORDPRESS_ADMIN_EMAIL}" --skip-email --allow-root --path="/var/www/html"
# wp core install --allow-root --url="${DOMAIN_NAME}" --title="WordPress Title" --admin_user="${WORDPRESS_ADMIN_NAME}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" --admin_email="${WORDPRESS_ADMIN_EMAIL}" --skip-email --allow-root --path="/var/www/html"

echo "	--- WordPress 'config' is created. "

#진님표
wp core install --url="${DOMAIN_NAME}" --title="${WORDPRESS_TITLE}" --admin_user="${WORDPRESS_ADMIN_NAME}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" --admin_email="${WORDPRESS_ADMIN_EMAIL}" --skip-email --allow-root
# wp user create --allow-root "${WORDPRESS_USER_NAME}" "${WORDPRESS_USER_EMAIL}" --user_pass="${WORDPRESS_USER_PASSWORD}" --role=author --path="/var/www/html"

echo "	--- WordPress 'core' is installed. "

wp user create "${WORDPRESS_USER_NAME}" "${WORDPRESS_USER_EMAIL}" --user_pass="${WORDPRESS_USER_PASSWORD}" --role=author --allow-root 


echo " --- WordPress 'user' is created. "

# wp theme install astra --activate --allow-root --path="/var/www/html"
wp theme install astra --activate --allow-root

echo " --- WordPress 'theme' is installed. "

echo "WordPress setup complete."

echo "WordPress is already set up."


sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# wp cli update



# chown -R www-data:www-data /var/www/html/
# PHP-FPM 프로세스 실행
exec /usr/sbin/php-fpm7.4 -F
