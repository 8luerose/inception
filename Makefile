# 프로젝트 이름과 사용자 변수 설정
NAME = inception
USER = taehkwon

# Docker Compose 파일 위치 지정
COMPOSE_SOURCE = ./srcs/docker-compose.yml

# 사용할 볼륨 경로 설정
# 클러스터용 VOLUME_PATH = /home/$(USER)/data/mariadb /home/$(USER)/data/wordpress
VOLUME_PATH = /Users/rose/Desktop/hm/$(USER)/data/mariadb /Users/rose/Desktop/hm/$(USER)/data/wordpress
# 노트북용

# "잉? 고마 어떻게 2개가 됩니꺼?" -> make 명령은 변수에 저장된 값들을 공백으로 구분하여 인식
# 따라서, "args1", "args2"로 인식
# 예시) mkdir -p args1 args2

# '.PHONY'는 Make가 이 타겟이 파일 이름이 아님을 인식
.PHONY: all clean fclean ffclean re


# 'all' 타겟: 필요한 디렉토리를 생성하고 Docker 컨테이너를 시작
all:
	@mkdir -p $(VOLUME_PATH)  
	@docker-compose -f $(COMPOSE_SOURCE) up -d --build
# 필요한 볼륨 경로를 생성
# Docker 컨테이너를 빌드하고 백그라운드에서 실행


# 'clean' 타겟: Docker 컴포즈를 사용하여 서비스를 정지
clean:
	@docker-compose -f $(COMPOSE_SOURCE) down --volumes
# 'make clean'을 실행할 때 수행할 작업을 정의
# 실행 중인 Docker 컨테이너를 중지하고 제거


# 'fclean' 타겟: 서비스를 정지하고 모든 이미지와 볼륨을 제거
fclean: clean
	@docker-compose -f $(COMPOSE_SOURCE) down --rmi all --volumes
	@docker volume prune -f
	@docker network prune -f
# 모든 이미지와 관련 볼륨을 제거


# 'ffclean' 타겟: fclean을 수행하고 지정된 볼륨 경로를 삭제
ffclean: fclean
	@sudo rm -rf $(VOLUME_PATH)
	@docker system prune -a -f
# 설정된 볼륨 경로를 완전히 제거
# 사용하지 않는 Docker 리소스를 강제로 제거


# 're' 타겟: ffclean을 수행하고 all 타겟을 다시 실행
re: ffclean
	@$(MAKE) all
# 'all' 명령을 재실행하여 프로젝트를 처음부터 다시 설정
