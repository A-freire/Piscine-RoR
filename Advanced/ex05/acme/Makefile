SHELL := /bin/bash

.PHONY: all db init app clean fclean rubycritic

all:
	@printf "Utilise les commandes suivantes :\n"
	@printf "1. make db\n"
	@printf "2. make init\n"
	@printf "3. make app\n"

db:
	@cp -n .env.example .env 2>/dev/null || true
	@docker compose build
	@docker compose up db

init:
	@cp -n .env.example .env 2>/dev/null || true
	@docker compose build
	@docker compose run --rm web bundle install
	@docker compose run --rm web bundle exec rails db:environment:set db:drop db:create db:migrate
	@docker compose run --rm web bundle exec rails db:seed

app:
	@cp -n .env.example .env 2>/dev/null || true
	@docker compose build
	@docker compose run --rm web bundle install
	@docker compose up web

clean:
	@docker compose down --remove-orphans || true

fclean:
	@docker compose down -v --remove-orphans || true

rubycritic:
	@cp -n .env.example .env 2>/dev/null || true
	@docker compose build
	@docker compose run --rm web bundle install
	@docker compose run --rm web bundle exec rubycritic --no-browser app config lib
