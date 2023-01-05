DOCKER_USER=nielshojen
ADMIN_PASS=password
MACNAMER_PORT=8000
DB_NAME=macnamer
DB_PASS=password
DB_USER=macnamer
DB_CONTAINER_NAME:=postgres:9.6
NAME:=macnamer
PLUGIN_DIR=/tmp/plugins
# DOCKER_RUN_COMMON=--name="$(NAME)" -p ${MACNAMER_PORT}:8000 --link $(DB_CONTAINER_NAME):db -e ADMIN_PASS=${ADMIN_PASS} -e DB_NAME=$(DB_NAME) -e DB_USER=$(DB_USER) -e DB_PASS=$(DB_PASS) -v ${PLUGIN_DIR}:/home/app/sal/plugins ${DOCKER_USER}/macnamer

DOCKER_RUN_COMMON=--name="$(NAME)" -p ${MACNAMER_PORT}:8000 -e ADMIN_PASS=${ADMIN_PASS} ${DOCKER_USER}/${NAME}

all: build

build:
	docker build --platform linux/amd64  --tag "${DOCKER_USER}/${NAME}" .

build-nocache:
	docker build --platform linux/amd64 --no-cache --tag "${DOCKER_USER}/${NAME}" .

run:
	docker run -d ${DOCKER_RUN_COMMON}

interactive:
	docker run -i ${DOCKER_RUN_COMMON}

bash:
	docker run -t -i ${DOCKER_RUN_COMMON} /bin/bash

clean:
	docker stop $(NAME)
	docker rm $(NAME)

rmi:
	docker rmi ${DOCKER_USER}/${NAME}

postgres:
	docker run --name="${DB_CONTAINER_NAME}" -d

postgres-clean:
	docker stop $(DB_CONTAINER_NAME)
	docker rm $(DB_CONTAINER_NAME)