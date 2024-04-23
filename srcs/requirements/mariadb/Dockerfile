# # 기반 이미지 설정
# FROM debian:bullseye

# # 필수 패키지 설치 및 설정
# RUN apt-get -y update \
#     && apt-get -y install mariadb-server mariadb-client \
#     # && mkdir -p /var/lib/mysql /run/mysqld \
#     # && mkdir -p /var/lib/mysql \
#     && mkdir -p /run/mysqld \
#     && chmod 755 /run/mysqld \
# 	# && chmod 777 /var/lib/mysql \
# 	&& find /var/lib/mysql -type f -exec chmod 644 {} \; \
#     && find /var/lib/mysql -type d -exec chmod 755 {} \; \
#     && chown -R mysql:mysql /run/mysqld /var/lib/mysql \
# 	# && rm -rf /var/lib/mysql/*
# 	&& rm -rf /var/lib/mysql/aria_log_control

# # 설정 파일 및 스크립트 복사
# COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# # COPY tools/init.sh /usr/local/bin/init.sh
# # COPY --chown=root:root tools/init.sh ./init.sh
# COPY tools/init.sh ./init.sh


# # 스크립트 실행 권한 부여
# # RUN chmod 755 /usr/local/bin/init.sh \
# RUN chmod 777 ./init.sh \
#     && chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

# # 포트 및 볼륨 설정
# EXPOSE 3306
# # VOLUME ["/var/lib/mysql"]

# # 초기화 스크립트 실행
# # ENTRYPOINT ["/usr/local/bin/init.sh"]
# # ENTRYPOINT ["./init.sh", "mariadbd"]
# ENTRYPOINT ["./init.sh"]

FROM	debian:bullseye

RUN 	apt-get -y update \
		&& apt-get -y install dumb-init
		
RUN		apt-get -y install mariadb-server mariadb-client \
		&& mkdir /run/mysqld \
		&& chmod 777 /run/mysqld \
		&& chmod 777 /var/lib/mysql \
		&& rm -rf /var/lib/mysql/aria_log_control
		# && rm -rf /var/lib/mysql/*

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	tools/settings.sh ./init.sh

RUN		chmod 044 /etc/mysql/mariadb.conf.d/50-server.cnf
RUN		chmod 755 ./init.sh

ENTRYPOINT	["/usr/bin/dumb-init", "--"]

CMD		["./init.sh"]