NAME			=		inception
YML				=		srcs/docker-compose.yml
COMPOSE_FLAGS	=		--parallel --compress

$(NAME): build d

all: $(NAME)

re: fclean all

fclean: clean

down:
	docker-compose -f $(YML) down

up: build
	docker-compose -f $(YML) up

d:
	docker-compose -f $(YML) up -d

clean:
	docker stop $$(docker ps -q) || true
	docker rm $$(docker ps -aq) || true

prune:
	yes | docker system prune --volumes
	yes | docker system prune

build: $(YML)
	docker-compose -f $(YML) build $(COMPOSE_FLAGS)

push:
	git add srcs Makefile .gitignore
	git commit -m "$$(date +%Y%m%d%H%M%S)"
	git push

.PHONY: all inception build