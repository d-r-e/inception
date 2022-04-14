all: build
	docker-compose up

build:
	docker-compose -f srcs/docker-compose.yml build