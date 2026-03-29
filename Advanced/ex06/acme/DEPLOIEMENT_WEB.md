# Deploiement Web de `acme`

Ce guide explique comment mettre en ligne `ex06/acme` sans VM, en utilisant Docker sur Render.

## Option recommandee

Je te conseille **Render** parce que :

- il heberge facilement une app Rails via Docker ;
- il propose PostgreSQL gere ;
- tu peux deployer un sous-dossier d'un repo via un `Root Directory`.

## Prerequis

Avant de commencer, il faut :

1. pousser le projet sur GitHub, GitLab ou Bitbucket ;
2. avoir un compte Render ;
3. avoir un compte Cloudinary si tu veux que les uploads d'images fonctionnent vraiment en ligne ;
4. choisir le dossier a deployer : ici `ex06/acme`.

## Ce que ton hebergeur doit lancer

Ton app est deja prete pour :

- Ruby on Rails ;
- PostgreSQL ;
- execution Docker ;
- variables d'environnement ;
- `DATABASE_URL` en production.

## Etapes sur Render

### 1. Creer la base PostgreSQL

Dans Render :

1. clique sur `New` puis `PostgreSQL` ;
2. cree une base ;
3. attends qu'elle soit prete ;
4. recupere son `Internal Database URL`.

Garde cette URL pour la variable `DATABASE_URL`.

### 2. Creer le service web

Dans Render :

1. clique sur `New` puis `Web Service` ;
2. connecte ton repo ;
3. choisis la branche a deployer ;
4. choisis le runtime `Docker`.

Configuration conseillee :

- `Root Directory` : `ex06/acme`
- `Dockerfile Path` : `Dockerfile`
- `Docker Context` : `.`

Si tu ne mets pas `Root Directory`, il faudra adapter les chemins manuellement.

### 3. Ajouter les variables d'environnement

Ajoute au minimum :

- `DATABASE_URL` : l'`Internal Database URL` de ta base Render
- `RAILS_ENV` : `production`
- `RAILS_LOG_TO_STDOUT` : `true`
- `RAILS_SERVE_STATIC_FILES` : `true`
- `OWNER_LOGIN` : `bexas`
- `APP_HOST` : ton domaine Render, par exemple `acme-xxxx.onrender.com`
- `APP_PROTOCOL` : `https`

Pour les images Cloudinary :

- `CLOUDINARY_CLOUD_NAME`
- `CLOUDINARY_API_KEY`
- `CLOUDINARY_API_SECRET`

Option utile si Render ne detecte pas automatiquement le port :

- `PORT` : `3000`

## 4. Lancer le premier deploy

Une fois le service cree :

1. lance le deploy ;
2. attends que l'image Docker soit build ;
3. verifie que le service passe en `Live`.

## 5. Executer les migrations

Apres le premier deploy, ouvre un shell Render sur le service web et execute :

```bash
bundle exec rails db:migrate
```

## 6. Peupler la base

Dans le shell Render, execute ensuite :

```bash
bundle exec rails db:seed
```

La seed doit creer :

- 50 marques ;
- 2500 produits ;
- 20 utilisateurs ;
- 1 admin ;
- 5 mod.

## 7. Verifications a faire en ligne

Quand le site est en ligne, verifie :

1. la page d'accueil charge bien ;
2. ton login `bexas` est visible sur le site ;
3. tu peux creer un compte ;
4. `admin@gmail.com` / `password` fonctionne ;
5. le catalogue affiche bien les produits ;
6. le panier fonctionne ;
7. le panneau `/admin` fonctionne ;
8. les roles limitent bien les droits ;
9. les images s'affichent bien.

## Compte de demo

La seed cree :

- email : `admin@gmail.com`
- mot de passe : `password`

## Domaine perso optionnel

Si tu veux un vrai nom de domaine :

1. ajoute ton domaine dans Render ;
2. configure les enregistrements DNS demandes ;
3. attends la propagation ;
4. mets `APP_HOST` a jour avec ton vrai domaine.

## Problemes frequents

### L'app ne demarre pas

Regarde les logs Render et verifie :

- que `DATABASE_URL` est bien renseignee ;
- que la base PostgreSQL est accessible ;
- que les migrations ont ete lancees.

### Les images ne marchent pas en production

Verifie :

- les variables Cloudinary ;
- que ton compte Cloudinary est actif ;
- que les uploads se font bien apres deploy.

### La page `/admin` refuse l'acces

Connecte-toi avec :

- `admin@gmail.com`
- `password`

## Ce que tu pourras dire a l'eval

Tu pourras expliquer que :

- le sujet demandait une VM, mais tu l'as adapte proprement a Docker ;
- PostgreSQL tourne en service separe ;
- l'app Rails tourne dans un conteneur ;
- les variables d'environnement remplacent la config locale ;
- le deploiement web couvre auth, panier, roles, admin et uploads.

## Resume ultra court

1. Push du repo.
2. Base Postgres sur Render.
3. Web Service Docker avec `Root Directory = ex06/acme`.
4. Ajouter `DATABASE_URL`, `OWNER_LOGIN`, `APP_HOST`, `APP_PROTOCOL`, Cloudinary.
5. Deploy.
6. `bundle exec rails db:migrate`
7. `bundle exec rails db:seed`
8. Tester le site en ligne.
