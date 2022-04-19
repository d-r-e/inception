NAME			=		inception
YML				=		srcs/docker-compose.yml
COMPOSE_FLAGS	=		--parallel
VOLUMES = $$HOME/data
$(NAME): build up

all: $(NAME)

re: fclean all

fclean: clean
	docker volume rm $$(docker volume ls -q -f dangling=true) || true
	rm -rf $(VOLUMES)
	rm -rf $$HOME/data

down:
	docker-compose -f $(YML) down

up:
	docker-compose -f $(YML) up

d:
	docker-compose -f $(YML) up -d

wp:
	docker-compose -f $(YML)  up -d --build wordpress
db:
	docker-compose -f $(YML)  up -d --build mariadb
ng:
	docker-compose -f $(YML)  up -d --build nginx
clean:
	docker stop $$(docker ps -q) || true
	docker rm $$(docker ps -aq) || true

prune:
	yes | docker system prune --volumes
	yes | docker system prune

build: $(YML)
	mkdir -p $$HOME/data/dbdata
	mkdir -p $$HOME/data/wpdata
	docker-compose -f $(YML) build $(COMPOSE_FLAGS)

push:
	git add srcs Makefile .gitignore
	git commit -m "$$(date +%Y%m%d%H%M%S)"
	git push

.PHONY: all inception build push prune clean down