APP_DIR := Xnote
IMAGE := piscine-ror-ex00-xnote
CONTAINER := $(IMAGE)
SHELL_CONTAINER := $(CONTAINER)-shell
BUNDLE_VOLUME := $(CONTAINER)-bundle
PORT := 3000

.PHONY: build run interactive shell clean

build:
	docker build -t $(IMAGE) $(APP_DIR)

run: build
	@docker rm -f $(CONTAINER) >/dev/null 2>&1 || true
	docker run --rm --name $(CONTAINER) \
		-p $(PORT):3000 \
		-v "$(CURDIR)/$(APP_DIR):/app" \
		-v $(BUNDLE_VOLUME):/usr/local/bundle \
		$(IMAGE)

interactive: build
	@docker rm -f $(SHELL_CONTAINER) >/dev/null 2>&1 || true
	docker run --rm -it --name $(SHELL_CONTAINER) \
		-p $(PORT):3000 \
		-v "$(CURDIR)/$(APP_DIR):/app" \
		-v $(BUNDLE_VOLUME):/usr/local/bundle \
		--entrypoint /bin/bash \
		$(IMAGE)

shell: interactive

clean:
	@docker rm -f $(CONTAINER) $(SHELL_CONTAINER) >/dev/null 2>&1 || true
	@docker image rm -f $(IMAGE) >/dev/null 2>&1 || true
	@docker volume rm -f $(BUNDLE_VOLUME) >/dev/null 2>&1 || true
