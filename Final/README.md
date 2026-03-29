# Final

Sujet Rails final adapte pour Docker au lieu d'une VM.

## Structure

- `ex00` a `ex03`: application `Xnote`
- `ex04` a `ex06`: application `Chat`

Chaque exercice contient sa propre app Rails et son propre `docker-compose.yml`.

## Lancer Xnote

Depuis l'exercice voulu:

```bash
cd ex03/Xnote
docker compose run --rm web bundle exec rails db:migrate
docker compose up --build
```

Application disponible sur `http://localhost:3000`.

Les exercices `ex00`, `ex01`, `ex02`, `ex03` partagent la meme base Docker.

## Lancer Chat

Depuis l'exercice voulu:

```bash
cd ex06/Chat
docker compose run --rm web bundle exec rails db:migrate
docker compose up --build
```

Application disponible sur `http://localhost:3001`.

Les exercices `ex04`, `ex05`, `ex06` utilisent Redis via Docker Compose pour Action Cable.

## Progression des exercices

- `ex00`: creation AJAX + validation d'unicite
- `ex01`: creation + suppression AJAX
- `ex02`: edition inline AJAX
- `ex03`: compteur total de livres mis a jour en direct
- `ex04`: chat global temps reel avec Devise
- `ex05`: ChatRooms et messages isoles par salle
- `ex06`: notifications temps reel + compteur + son
