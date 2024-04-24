FROM debian:bullseye

# 패키지 목록 업데이트 및 필요한 패키지 설치
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    mariadb-client \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql
    # php7.4-xml \
    # php7.4-curl \
    # php7.4-gd \
    # php7.4-mbstring \
    # php7.4-cli \
    # && rm -rf /var/lib/apt/lists/*


# WP-CLI 설치
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
	# && mkdir -p /var/www/html \
	# && mkdir -p /tmp

# COPY ./tools/wp-config.php /var/www/html/wp-config.php
# COPY ./conf/wp-config.php /tmp/wp-config.php

	
	# RUN mkdir -p /var/log/php7.4-fpm && chown www-data:www-data /var/log/php7.4-fpm \
	# 	&& mkdir -p /run/php && chown -R www-data:www-data /run/php
	
RUN mkdir -p /run/php && chmod 777 /run/php
	
	
# PHP-FPM 설정 파일 복사
# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
# 실행 스크립트 복사 및 실행 권한 부여
COPY ./tools/wordpress_setting.sh /wordpress_setting.sh
# RUN chmod +x /wordpress_setting.sh
RUN chmod 777 /wordpress_setting.sh
# 컨테이너 시작 시 실행할 명령어
# ENTRYPOINT ["/wordpress_setting.sh"]
# CMD ["php-fpm7.4", "-F"]

CMD ["./wordpress_setting.sh"]

# 9000 포트 개방
EXPOSE 9000