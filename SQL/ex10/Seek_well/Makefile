IMAGE_NAME ?= sql-ex10-seek-well
PORT ?= 3000
RUN := docker run --rm -v "$(PWD):/app" $(IMAGE_NAME)
RUN_WEB := docker run --rm -p $(PORT):3000 -v "$(PWD):/app" $(IMAGE_NAME)
RUN_WEB_CMD := bash -lc 'bundle exec rails db:prepare db:seed && bundle exec rails server -b 0.0.0.0'
RUN_TTY := docker run --rm -it -v "$(PWD):/app" $(IMAGE_NAME)

.PHONY: help build run test shell

help:
	@printf "%s\n" \
		"Targets disponibles:" \
		"  make build  - build l'image Docker $(IMAGE_NAME)" \
		"  make run    - seed puis lance l'application sur http://localhost:$(PORT)" \
		"  make test   - lance les tests du controller ft_query" \
		"  make shell  - ouvre un shell dans le conteneur"

build:
	docker build -t $(IMAGE_NAME) .

run: build
	$(RUN_WEB) $(RUN_WEB_CMD)

test: build
	$(RUN) bash -lc 'rm -f ft_sql db/test.sqlite3 && bundle exec rails test test/controllers/ft_query_controller_test.rb'

shell: build
	$(RUN_TTY) bash
