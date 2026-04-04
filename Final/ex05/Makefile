APP_DIR := Chat
IMAGE := piscine-ror-ex05-chat
CONTAINER := $(IMAGE)
SHELL_CONTAINER := $(CONTAINER)-shell
REDIS_CONTAINER := $(CONTAINER)-redis
BUNDLE_VOLUME := $(CONTAINER)-bundle
NETWORK := $(CONTAINER)-net
PORT := 3001
REDIS_URL := redis://redis:6379/1

.PHONY: build run interactive shell clean network-up redis-up

build:
	docker build -t $(IMAGE) $(APP_DIR)

network-up:
	@docker network inspect $(NETWORK) >/dev/null 2>&1 || docker network create $(NETWORK) >/dev/null

redis-up: network-up
	@docker rm -f $(REDIS_CONTAINER) >/dev/null 2>&1 || true
	docker run -d --rm --name $(REDIS_CONTAINER) \
		--network $(NETWORK) \
		--network-alias redis \
		redis:7-alpine >/dev/null

run: build redis-up
	@docker rm -f $(CONTAINER) >/dev/null 2>&1 || true
	docker run --rm --name $(CONTAINER) \
		--network $(NETWORK) \
		-e REDIS_URL=$(REDIS_URL) \
		-p $(PORT):3000 \
		-v "$(CURDIR)/$(APP_DIR):/app" \
		-v $(BUNDLE_VOLUME):/usr/local/bundle \
		$(IMAGE)

interactive: build redis-up
	@docker rm -f $(SHELL_CONTAINER) >/dev/null 2>&1 || true
	docker run --rm -it --name $(SHELL_CONTAINER) \
		--network $(NETWORK) \
		-e REDIS_URL=$(REDIS_URL) \
		-p $(PORT):3000 \
		-v "$(CURDIR)/$(APP_DIR):/app" \
		-v $(BUNDLE_VOLUME):/usr/local/bundle \
		--entrypoint /bin/bash \
		$(IMAGE)

shell: interactive

clean:
	@docker rm -f $(CONTAINER) $(SHELL_CONTAINER) $(REDIS_CONTAINER) >/dev/null 2>&1 || true
	@docker network rm $(NETWORK) >/dev/null 2>&1 || true
	@docker image rm -f $(IMAGE) >/dev/null 2>&1 || true
	@docker volume rm -f $(BUNDLE_VOLUME) >/dev/null 2>&1 || true
