IMAGE_NAME ?= sql-ex07-tweetos
PORT ?= 3000
RUN := docker run --rm -v "$(PWD):/app" $(IMAGE_NAME)
RUN_WEB := docker run --rm -p $(PORT):3000 -v "$(PWD):/app" $(IMAGE_NAME)
RUN_TTY := docker run --rm -it -v "$(PWD):/app" $(IMAGE_NAME)
VIEW_CMD := bash -lc 'gem list -i colorize >/dev/null || gem install colorize >/dev/null; gem list -i pry >/dev/null || gem install pry >/dev/null; ruby views_com.rb

.PHONY: help build run test shell views-uncomment views-comment

help:
	@printf "%s\n" \
		"Targets disponibles:" \
		"  make build            - build l'image Docker $(IMAGE_NAME)" \
		"  make run              - lance l'application sur http://localhost:$(PORT)" \
		"  make test             - lance la suite de tests Rails" \
		"  make shell            - ouvre un shell dans le conteneur" \
		"  make views-uncomment  - decommente les vues via views_com.rb" \
		"  make views-comment    - recommente les vues via views_com.rb"

build:
	docker build -t $(IMAGE_NAME) .

run: build
	$(RUN_WEB)

test: build
	$(RUN) bash -lc 'rm -f db/test.sqlite3 && RAILS_ENV=test bundle exec rails db:drop db:create db:migrate && bundle exec rails test'

shell: build
	$(RUN_TTY) bash

views-uncomment: build
	$(RUN) $(VIEW_CMD) unco'

views-comment: build
	$(RUN) $(VIEW_CMD) co'
