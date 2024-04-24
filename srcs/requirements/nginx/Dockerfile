# FROM debian:buster

# # Nginx와 OpenSSL 설치
# RUN apt-get update && \
#     apt-get install -y nginx openssl

# # SSL 인증서 디렉터리 생성
# RUN mkdir -p /etc/nginx/ssl

# # Nginx 설정 파일 복사
# COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# # Nginx 실행을 위한 포트 노출
# EXPOSE 443

# # Nginx 시작
# CMD ["nginx", "-g", "daemon off;"]

FROM debian:bullseye

# Nginx와 OpenSSL 설치
RUN apt-get update && \
    apt-get install -y nginx openssl

# SSL 인증서 디렉터리 생성
# RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /etc/nginx/ssl/ && \
	chmod 777 /etc/nginx/ssl

# SSL 인증서 생성
RUN openssl req -newkey rsa:2048 -x509 -days 365 -nodes \
    # -out /etc/nginx/ssl/nginx.crt \
	# -keyout /etc/nginx/ssl/taehkwon.key \
	# -out /etc/nginx/ssl/taehkwon.pem \
    # -keyout /etc/nginx/ssl/nginx.key \
	# -keyout /etc/ssl/private/taehkwon.pem \
	# -out /etc/ssl/certs/taehkwon.crt \
	-keyout /etc/nginx/ssl/nginx.pem \
	-out /etc/nginx/ssl/nginx.crt \
    -subj "/C=KR/ST=Seoul/L=Seoul/O=42/CN=$DOMAIN_NAME"

RUN chmod +r  /etc/nginx/ssl/nginx.pem && \
	chmod +r  /etc/nginx/ssl/nginx.crt

# Nginx 설정 파일 복사
# COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY	conf/default /etc/nginx/sites-available/default

# Nginx 시작
CMD ["nginx", "-g", "daemon off;"]

# Nginx 실행을 위한 포트 노출
EXPOSE 443