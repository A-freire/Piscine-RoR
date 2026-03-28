IMAGE_NAME = helloworld-rails
CONTAINER_NAME = helloworld-rails
WORKDIR = /rails
RUBY_VERSION ?= 3.4.4

.PHONY: help build run clean

help:
	@echo "Commandes disponibles :"
	@echo "  make build  -> Build l'image Docker Ruby/Rails"
	@echo "  make run    -> Lance directement le serveur Rails sur localhost:3000"
	@echo "  make clean  -> Supprime le conteneur et l'image Docker"

build:
	docker build --build-arg RUBY_VERSION=$(RUBY_VERSION) -t $(IMAGE_NAME) .

run: build
	-@docker rm -f $(CONTAINER_NAME) >/dev/null 2>&1 || true
	docker run --rm --name $(CONTAINER_NAME) -p 3000:3000 -v "$(CURDIR):$(WORKDIR)" -w $(WORKDIR) $(IMAGE_NAME)

clean:
	-@docker rm -f $(CONTAINER_NAME) >/dev/null 2>&1 || true
	-@docker rmi $(IMAGE_NAME) >/dev/null 2>&1 || true
