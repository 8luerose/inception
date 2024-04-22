# 기반 이미지 설정
FROM debian:bullseye

# 필수 패키지 설치 및 설정
RUN apt-get update \
    && apt-get install -y mariadb-server mariadb-client \
    # && mkdir -p /var/lib/mysql /run/mysqld \
    # && mkdir -p /var/lib/mysql \
    && mkdir -p /run/mysqld \
    && chmod 777 /run/mysqld \
	&& chmod 777 /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql \
	&& rm -rf /var/lib/mysql/*

# 설정 파일 및 스크립트 복사
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# COPY tools/init.sh /usr/local/bin/init.sh
# COPY --chown=root:root tools/init.sh ./init.sh
COPY tools/init.sh ./init.sh


# 스크립트 실행 권한 부여
# RUN chmod 755 /usr/local/bin/init.sh \
RUN chmod 755 ./init.sh \
    && chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

# 포트 및 볼륨 설정
EXPOSE 3306
# VOLUME ["/var/lib/mysql"]

# 초기화 스크립트 실행
# ENTRYPOINT ["/usr/local/bin/init.sh"]
ENTRYPOINT ["./init.sh", "mariadbd"]

