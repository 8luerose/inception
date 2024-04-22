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
RUN mkdir -p /etc/nginx/ssl

# SSL 인증서 생성
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    # -out /etc/nginx/ssl/nginx.crt \
	-out /etc/nginx/ssl/taehkwon.pem \
    # -keyout /etc/nginx/ssl/nginx.key \
	-keyout /etc/nginx/ssl/taehkwon.key \
    -subj "/C=KR/ST=Seoul/L=Seoul/O=42/CN=localhost"

# Nginx 설정 파일 복사
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# Nginx 실행을 위한 포트 노출
EXPOSE 443

# Nginx 시작
CMD ["nginx", "-g", "daemon off;"]