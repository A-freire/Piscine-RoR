IMAGE_NAME = deepthought-ruby
CONTAINER_NAME = deepthought-ruby-shell
WORKDIR = /app
RUBY_VERSION ?= 3.4.4

.PHONY: help build start setup shell clean

help:
	@echo "Commandes disponibles :"
	@echo "  make build  -> Build l'image Docker Ruby"
	@echo "  make start  -> Lance le conteneur en arriere-plan"
	@echo "  make setup  -> Installe les gems avec bundle install"
	@echo "  make shell  -> Ouvre un shell interactif dans le conteneur"
	@echo "  make clean  -> Supprime le conteneur et l'image Docker"

build:
	docker build --build-arg RUBY_VERSION=$(RUBY_VERSION) -t $(IMAGE_NAME) .

start: build
	@if ! docker ps -a --format '{{.Names}}' | grep -qx '$(CONTAINER_NAME)'; then \
		docker run -dit --name $(CONTAINER_NAME) -v "$(CURDIR):$(WORKDIR)" -w $(WORKDIR) $(IMAGE_NAME) sleep infinity >/dev/null; \
	elif [ "$$(docker inspect -f '{{.State.Running}}' $(CONTAINER_NAME))" != "true" ]; then \
		docker start $(CONTAINER_NAME) >/dev/null; \
	fi

setup: start
	docker exec $(CONTAINER_NAME) bash -lc "bundle install"

shell: setup
	docker exec -it $(CONTAINER_NAME) bash

clean:
	-@docker rm -f $(CONTAINER_NAME) >/dev/null 2>&1 || true
	-@docker rmi $(IMAGE_NAME) >/dev/null 2>&1 || true
