# Soutenance Module 06

Ce fichier sert de pense-bete pour la soutenance.

## Comptes de test

Tous les comptes de seed utilisent le mot de passe `password123`.

- `admin`
- `bob2`
- `Stephan`
- `alice`
- `mentor`
- `rookie`

## Lancement rapide avec Docker

Chaque exercice contient un `Dockerfile` et un `Makefile`.
Le `make run` lance aussi le `db:seed`, donc les comptes de test sont recréés automatiquement dans Docker.

Exemples :

```sh
cd /Users/bexas/Repo/Piscine-RoR/Sessions/ex00/LifeProTips
make build
make run
```

Ports par defaut :

- `ex00` : `http://localhost:3000`
- `ex01` : `http://localhost:3001`
- `ex02` : `http://localhost:3002`
- `ex03` : `http://localhost:3003`
- `ex04` : `http://localhost:3004`
- `ex05` : `http://localhost:3005`

Nettoyage :

```sh
make clean
```

## Fil conducteur de la demo

Commence par lancer l'exercice cible, puis montre :

1. la page d'accueil
2. la ligne d'utilisateur en haut
3. les redirects et les protections d'acces
4. le namespace admin `/admin/...`
5. les donnees de seed

## Ex00

Objectif a montrer :

- visiteur anonyme avec un nom d'animal
- `Sign_in` vers le formulaire d'inscription
- `Log_in` vers le formulaire de connexion
- `Log_out`
- inscription avec connexion automatique
- mot de passe non visible dans le formulaire
- validations : unicite nom/email, mot de passe >= 8
- cookie visiteur valable 1 minute

Demo conseillee :

1. ouvrir la home en anonyme
2. montrer `Welcome <AnimalName> visitor!`
3. rafraichir vite pour montrer que le nom reste le meme
4. attendre 1 minute puis rafraichir pour montrer qu'il change
5. creer un compte
6. montrer qu'apres creation on est connecte
7. se deconnecter
8. se reconnecter avec un user de seed

## Ex01

Objectif a montrer :

- `admin` boolean en base
- pages admin sous `/admin/users`
- un admin peut lister, editer, supprimer les users
- un user normal peut seulement editer son propre profil
- le header admin affiche `Administrate_users`

Demo conseillee :

1. se connecter avec `alice`
2. tenter d'acceder a `/admin/users` et montrer le refus
3. montrer qu'`alice` peut editer seulement son profil
4. se connecter avec `admin`
5. ouvrir `/admin/users`
6. modifier un user puis revenir a l'index admin

## Ex02

Objectif a montrer :

- root page = index des posts
- posts avec `title`, `content`, `user_id`
- index trie du plus recent au plus ancien
- auteur affiche par son nom
- un visiteur voit l'index mais pas le show
- si un visiteur clique un titre, redirect home avec notice
- un user cree un post sans choisir son `user_id`
- admin des posts sous `/admin/posts`

Demo conseillee :

1. en anonyme, montrer l'index
2. cliquer sur un titre et montrer la redirection avec notice
3. se connecter avec `bob2`
4. creer un post
5. montrer qu'il apparait en tete si c'est le plus recent
6. se connecter en admin
7. ouvrir `/admin/posts`

## Ex03

Objectif a montrer :

- trace de la derniere edition d'un post
- affichage de `Edited by`
- affichage de `Date of modification`
- pas de variable globale ni solution cookie pour cela

Demo conseillee :

1. ouvrir un post deja edite par la seed
2. montrer l'auteur original
3. montrer `Edited by` et la date
4. editer un post avec un autre utilisateur autorise
5. revenir sur le show pour montrer la mise a jour de la trace

## Ex04

Objectif a montrer :

- up-vote et down-vote sur la page show
- total des votes, meme negatif
- un user normal ne vote qu'une fois par post
- il peut modifier son vote en changeant `+1` vers `-1`
- les votes sont des objets ActiveRecord
- interface admin des votes
- exception voulue : un admin peut upvote plusieurs fois

Demo conseillee :

1. ouvrir le show d'un post
2. voter en `+1`
3. revoter en `-1` avec le meme user et montrer que le total change sans creer une seconde ligne utilisateur normale
4. ouvrir `/admin/votes`
5. montrer les votes regroupes par post
6. supprimer un vote depuis l'admin
7. avec `admin`, faire plusieurs upvotes sur un meme post

## Ex05

Objectif a montrer :

- calcul des points d'un user = somme des votes recus sur ses posts
- droits progressifs selon le score
- droits visibles sur la page user
- droits visibles sur l'admin users
- a partir de `10` points, edition des posts d'autrui

Paliers a annoncer clairement :

- jusqu'a `1` point : aucun droit special
- de `2` a `3` points : up-vote
- de `4` a `5` points : down-vote
- `10` points ou plus : edition des posts d'autrui

Demo conseillee :

1. ouvrir la page profil de `rookie` et montrer l'absence de droits
2. ouvrir la page profil de `bob2` et montrer le droit d'upvote
3. ouvrir la page profil de `Stephan` et montrer le droit de downvote
4. ouvrir la page profil de `mentor` et montrer le droit d'editer les posts des autres
5. avec `mentor`, editer un post qui ne lui appartient pas
6. ouvrir `/admin/users` et montrer que les droits sont aussi visibles dans l'admin

## Commandes utiles a connaitre

Depuis un exercice :

```sh
make build
make run
make clean
bundle exec rails_best_practices .
bin/rails test
```
