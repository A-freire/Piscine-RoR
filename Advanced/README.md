# Advanced - Docker Version

Le sujet `Advanced.pdf` a ete realise en remplacant la contrainte "VM" par une execution Docker.

## Dossiers rendus

- `ex00/acme`
- `ex01/acme`
- `ex02/acme`
- `ex03/acme`
- `ex04/acme`
- `ex05/acme`
- `ex06/acme`

Chaque dossier contient une application Rails `acme` runnable avec Docker Compose.

## Commandes utiles

Depuis un dossier `ex0N/acme` :

1. `docker compose build`
2. `docker compose run --rm web bundle exec rails db:prepare`
3. `docker compose run --rm web bundle exec rails db:seed`
4. `docker compose up`

L'application est exposee sur `http://localhost:3000`.

## Variables utiles

- `OWNER_LOGIN` pour afficher le login sur le site
- `CLOUDINARY_CLOUD_NAME`
- `CLOUDINARY_API_KEY`
- `CLOUDINARY_API_SECRET`

Sans configuration Cloudinary, CarrierWave utilise un stockage local pour le developpement.
