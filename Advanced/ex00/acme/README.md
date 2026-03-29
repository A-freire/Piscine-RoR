# Acme

Application Rails du sujet `Advanced.pdf`, adaptée pour tourner avec Docker au lieu d'une VM.

## Démarrage

1. Copier `.env.example` en `.env`.
2. Lancer `docker compose build`.
3. Lancer `docker compose run --rm web bundle exec rails db:prepare`.
4. Lancer `docker compose run --rm web bundle exec rails db:seed`.
5. Lancer `docker compose up`.

## Notes

- PostgreSQL tourne dans le service `db`.
- Les identifiants Cloudinary sont lus depuis `.env`.
- En l'absence de configuration Cloudinary, l'application bascule sur un stockage local CarrierWave pour le développement.
