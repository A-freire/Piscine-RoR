# SQL Piscine RoR

Les rendus sont fournis dans les dossiers `ex00` a `ex10`, en respectant les noms du sujet.

La seule adaptation volontaire par rapport au PDF est l'execution via Docker au lieu d'une VM.

## Lancer `Seek_well`

```bash
cd ex10/Seek_well
docker build -t seek-well .
docker run --rm -p 3000:3000 seek-well
```

## Tester `Seek_well`

```bash
cd ex10/Seek_well
docker build -t seek-well .
docker run --rm -v "$PWD:/app" seek-well bash -lc 'rm -f ft_sql db/test.sqlite3 && bundle exec rails test test/controllers/ft_query_controller_test.rb'
```

## Lancer `tweetos_aka_hello_rails`

```bash
cd ex09/tweetos_aka_hello_rails
docker build -t tweetos .
docker run --rm -p 3000:3000 tweetos
```

## Tester `tweetos_aka_hello_rails`

```bash
cd ex09/tweetos_aka_hello_rails
docker build -t tweetos .
docker run --rm -v "$PWD:/app" tweetos bash -lc 'rm -f db/test.sqlite3 && RAILS_ENV=test bundle exec rails db:drop db:create db:migrate && bundle exec rails test'
```
