# 프로젝트 이름과 사용자 변수 설정
# NAME = inception
# USER = taehkwon

# # Docker Compose 파일 위치 지정
# COMPOSE_SOURCE = ./srcs/docker-compose.yml

# # 사용할 볼륨 경로 설정
# # 클러스터용 VOLUME_PATH = /home/$(USER)/data/mariadb /home/$(USER)/data/wordpress
# # 노트북용
# VOLUME_PATH = /Users/rose/Desktop/hm/$(USER)/data/mariadb /Users/rose/Desktop/hm/$(USER)/data/wordpress

# # "잉? 고마 어떻게 2개가 됩니꺼?" -> make 명령은 변수에 저장된 값들을 공백으로 구분하여 인식
# # 따라서, "args1", "args2"로 인식
# # 예시) mkdir -p args1 args2


# all:
# 	make build
# 	make up

# build:
# 	@docker-compose -f $(COMPOSE_SOURCE) build

# up:
# 	@docker-compose -f $(COMPOSE_SOURCE) up -d

# down:
# 	@docker-compose -f $(COMPOSE_SOURCE) down

# start:
# 	@docker-compose -f $(COMPOSE_SOURCE) start

# stop:
# 	@docker-compose -f $(COMPOSE_SOURCE) stop

# clean: stop
# 	make down
# 	docker rm -f `docker ps -aq`
# 	docekr rmi -f `docker images -aq`
# 	docker builder prune -f


# fclean: clean
# 	@docker-compose -f $(COMPOSE_SOURCE) down --volumes
# 	@docker volume prune -f
# 	@docker network prune -f


# ffclean: fclean
# 	@sudo rm -rf $(VOLUME_PATH)
# 	@docker system prune -a -f



# # 're' 타겟: ffclean을 수행하고 all 타겟을 다시 실행
# re: fclean
# 	@MAKE all
# # 'all' 명령을 재실행하여 프로젝트를 처음부터 다시 설정

# # '.PHONY'는 Make가 이 타겟이 파일 이름이 아님을 인식
# .PHONY: all build up down start stop clean fclean ffclean re




# 프로젝트 이름과 사용자 변수 설정
NAME = inception
USER = taehkwon

# Docker Compose 파일 위치 지정
COMPOSE_SOURCE = ./srcs/docker-compose.yml

# 사용할 볼륨 경로 설정
# 클러스터용
# MARIADB_VOLUME_PATH = /home/$(USER)/data/mariadb
# WORDPRESS_VOLUME_PATH = /home/$(USER)/data/wordpress
# 노트북용
MARIADB_VOLUME_PATH = /Users/rose/Desktop/hm/$(USER)/data/mariadb
WORDPRESS_VOLUME_PATH = /Users/rose/Desktop/hm/$(USER)/data/wordpress

all: dirs
	@make build
	@make up

dirs:
	@mkdir -p $(MARIADB_VOLUME_PATH) $(WORDPRESS_VOLUME_PATH)

build:
	@docker-compose -f $(COMPOSE_SOURCE) build

up:
	@docker-compose -f $(COMPOSE_SOURCE) up -d

down:
	@docker-compose -f $(COMPOSE_SOURCE) down

start:
	@docker-compose -f $(COMPOSE_SOURCE) start

stop:
	@docker-compose -f $(COMPOSE_SOURCE) stop

clean: stop
	@make down
	@if [ $$(docker ps -aq | wc -l) -gt 0 ]; then docker rm -f $$(docker ps -aq); fi
	@if [ $$(docker images -aq | wc -l) -gt 0 ]; then docker rmi -f $$(docker images -aq); fi
	@docker builder prune -f

fclean: clean
	@docker-compose -f $(COMPOSE_SOURCE) down --volumes
	@docker volume prune -f
	@docker network prune -f

ffclean: fclean
	@sudo rm -rf $(MARIADB_VOLUME_PATH) $(WORDPRESS_VOLUME_PATH)
	@docker system prune -a -f

re: fclean
	@MAKE all

.PHONY: all dirs build up down start stop clean fclean ffclean re
