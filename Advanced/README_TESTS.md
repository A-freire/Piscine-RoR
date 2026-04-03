# README Tests

Ce fichier explique comment tester les exercices `ex00` a `ex06` un par un avant le deploiement web, en utilisant les `Makefile`.

## Regle importante

Avant de passer a l'exercice suivant, arrete toujours le precedent pour liberer `localhost:3000`.

Depuis le dossier de l'exercice courant :

```bash
make clean
```

## Procedure commune

Place-toi dans le dossier de l'exercice a tester.

Exemple avec `ex00` :

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex00/acme
make
```

ou

```bash
make all
```

Ensuite ouvre :

- [http://localhost:3000](http://localhost:3000)

## Commandes disponibles

Dans chaque dossier `ex0N/acme` :

```bash
make
make all
make clean
make rubycritic
```

## Ex00

Objectif :

- verifier que PostgreSQL fonctionne bien dans Docker ;
- verifier que l'application Rails demarre ;
- verifier que `db:create` passe sans erreur.

Checklist :

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex00/acme
make
```

Tu dois constater :

- pas d'erreur de connexion PostgreSQL ;
- l'application charge sur `http://localhost:3000`.

## Ex01

Objectif :

- tester Devise et les champs utilisateur demandes.

Checklist :

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex01/acme
make
```

Puis :

1. aller sur `/users/sign_up`
2. creer un compte avec :
   - `name`
   - `email`
   - `password`
   - `password_confirmation`
   - `bio`
3. se connecter
4. aller sur `/users/edit`
5. modifier :
   - nom
   - bio
   - email
   - mot de passe

Tu dois constater :

- creation de compte OK ;
- connexion OK ;
- edition du profil OK.

## Ex02

Objectif :

- tester les marques, les produits et les images.

Compte admin :

- email : `admin@gmail.com`
- mot de passe : `password`

Checklist :

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex02/acme
make
```

Puis :

1. se connecter en admin
2. ouvrir `/admin`
3. creer une marque
4. creer un produit
5. verifier dans le catalogue :
   - nom
   - image
   - description
   - marque
   - prix

Note :

- en local, si Cloudinary n'est pas configure, CarrierWave en stockage local suffit pour tester.

## Ex03

Objectif :

- tester le panier persistant.

Checklist :

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex03/acme
make
```

Puis :

1. depuis le catalogue, cliquer sur `Ajouter au panier`
2. ouvrir `/cart`
3. tester :
   - `+`
   - `-`
   - `Retirer`
   - `Vider le panier`
4. ajouter plusieurs produits
5. aller sur `Checkout`
6. verifier les quantites et le total

Test de persistance :

1. garder le meme navigateur
2. arreter le serveur avec `Ctrl+C`
3. relancer avec `make`
4. recharger le site

Tu dois constater :

- le panier est retrouve ;
- les quantites et les calculs sont corrects.

## Ex04

Objectif :

- tester RailsAdmin.

Checklist :

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex04/acme
make
```

Puis :

1. se connecter avec `admin@gmail.com` / `password`
2. cliquer sur `Admin`
3. verifier que tu peux :
   - voir les donnees
   - editer les donnees

## Ex05

Objectif :

- tester les roles et les permissions.

Comptes utiles :

- admin : `admin@gmail.com` / `password`
- modos : `mod1@gmail.com` a `mod5@gmail.com` / `password`
- users simples : `user1@gmail.com`, etc. / `password`

Checklist :

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex05/acme
make
```

Puis :

1. en admin :
   - verifier acces total a `/admin`
2. en modo :
   - verifier gestion de `Brand`
   - verifier gestion de `Product`
   - verifier qu'il n'a pas tous les droits admin
3. en user simple :
   - verifier refus d'acces a `/admin`
4. tester aussi des URLs directes

Tu dois constater :

- un admin peut tout faire ;
- un modo peut gerer produits et marques ;
- un simple user ne peut pas outrepasser ses droits.

## Ex06

Objectif :

- tester la version finale complete.

Checklist :

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex06/acme
make
```

Puis verifier :

- auth
- catalogue
- images
- panier
- checkout
- admin
- roles

Commande utile :

```bash
make rubycritic
docker compose run --rm web bundle exec rails runner 'admin = User.find_by!(email: "admin@gmail.com"); puts [Brand.count, Product.count, User.count, admin.admin?, User.with_role(:mod).count].inspect'
```

Resultat attendu :

```ruby
[50, 2500, 20, true, 5]
```

## Ordre conseille

Teste dans cet ordre :

1. `ex00`
2. `ex01`
3. `ex02`
4. `ex03`
5. `ex04`
6. `ex05`
7. `ex06`

## Exemple rapide

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex03/acme
make
```

Puis, quand tu as fini :

```bash
make clean
```
