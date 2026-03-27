APP_NAME := lifeprotips_ex01
IMAGE_NAME := $(APP_NAME):latest
CONTAINER_NAME := $(APP_NAME)_container
PORT ?= 3001

.PHONY: build run clean best_practices

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker rm -f $(CONTAINER_NAME) >/dev/null 2>&1 || true
	docker run --name $(CONTAINER_NAME) -p $(PORT):3000 $(IMAGE_NAME)

clean:
	docker rm -f $(CONTAINER_NAME) >/dev/null 2>&1 || true
	docker rmi -f $(IMAGE_NAME) >/dev/null 2>&1 || true

best_practices: build
	docker run --rm -it $(IMAGE_NAME) bash -lc "bundle exec rails_best_practices ."
