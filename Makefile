NAME=inception
YML=srcs/docker-compose.yml

$(NAME): build up

all: $(NAME)

re: fclean all

fclean: clean
	docker rm $$(docker ps -aq)
down:
	docker-compose -f $(YML) down

up:
	docker-compose -f $(YML) up

d:
	docker-compose -f $(YML) up -d

clean:
	docker ps -aq
	docker stop $$(docker ps -aq)

build:
	docker-compose -f $(YML) build

push:
	git add .
	git commit -m "$$(date +%Y%m%d%H%M%S)"
	git push

.PHONY: all inception