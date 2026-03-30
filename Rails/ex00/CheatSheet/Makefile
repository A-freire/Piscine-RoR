PORT ?= 3000
APP_URL := http://localhost:$(PORT)
IMAGE_NAME := piscine-ror-ex00
CONTAINER_NAME := piscine-ror-ex00
APP_DIR := /app
REPORT_FILE := $(CURDIR)/tmp/rubycritic/overview.html
RUBYCRITIC_RUN := docker run --rm -v "$(CURDIR):$(APP_DIR)" -w $(APP_DIR) $(IMAGE_NAME)

ifeq ($(shell uname),Darwin)
OPEN_CMD := open
else
OPEN_CMD := xdg-open
endif

.PHONY: help build start stop clean logs open run shell rubycritic open-rubycritic

help:
	@echo "Targets disponibles :"
	@echo "  make build        # build l'image Docker"
	@echo "  make start        # lance le conteneur et le serveur Rails"
	@echo "  make stop         # stoppe et supprime le conteneur"
	@echo "  make clean        # supprime le conteneur et l'image Docker"
	@echo "  make logs         # affiche les logs du conteneur"
	@echo "  make open         # ouvre le site dans le navigateur"
	@echo "  make rubycritic   # genere le rapport rubycritic et l'ouvre en local"
	@echo "  make run          # build, ouvre le site et lance le conteneur"
	@echo "  make shell        # ouvre un shell dans le conteneur"
	@echo "  make run PORT=4000"

build:
	docker build -t $(IMAGE_NAME) .

start: build stop
	docker run --name $(CONTAINER_NAME) -p $(PORT):3000 $(IMAGE_NAME)

stop:
	-@docker rm -f $(CONTAINER_NAME) >/dev/null 2>&1 || true

clean: stop
	-@docker rmi -f $(IMAGE_NAME) >/dev/null 2>&1 || true

logs:
	docker logs -f $(CONTAINER_NAME)

open:
	$(OPEN_CMD) $(APP_URL)

open-rubycritic:
	$(OPEN_CMD) $(REPORT_FILE)

rubycritic: build
	$(RUBYCRITIC_RUN) bash -lc "bundle exec rubycritic --no-browser"
	@echo "Rapport RubyCritic genere : $(REPORT_FILE)"
	@$(OPEN_CMD) $(REPORT_FILE) >/dev/null 2>&1 || true

run: build
	@echo "Site disponible sur $(APP_URL)"
	@$(OPEN_CMD) $(APP_URL) >/dev/null 2>&1 || true
	@docker rm -f $(CONTAINER_NAME) >/dev/null 2>&1 || true
	docker run --name $(CONTAINER_NAME) -p $(PORT):3000 $(IMAGE_NAME)

shell: build
	@docker rm -f $(CONTAINER_NAME)-shell >/dev/null 2>&1 || true
	docker run --rm -it --name $(CONTAINER_NAME)-shell -p $(PORT):3000 $(IMAGE_NAME) bash
