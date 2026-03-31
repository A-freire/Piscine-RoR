# SQL Piscine RoR

Ce depot regroupe les rendus des exercices `ex00` a `ex10` de la piscine SQL en Ruby on Rails.

Le module suit en pratique deux fils conducteurs :

- `Seek_well` : travail en SQL brut avec SQLite pilote depuis Rails
- `tweetos_aka_hello_rails` : travail avec ActiveRecord, migrations, associations, validations et interface CRUD

L'idee generale est de comprendre comment une application web manipule une base de donnees, d'abord a bas niveau avec des requetes SQL explicites, puis avec les abstractions proposees par Rails.

## Vue d'ensemble des exercices

### Ex00 - Seek_well

Introduction a SQLite sans ActiveRecord. On cree le fichier de base, les tables `race` et `clock_watch`, puis on commence a enregistrer une course.

### Ex01 - Tweetos aka Hello Rails

Introduction au schema relationnel avec Rails : migrations, modeles, validations et associations entre `users`, `cuicuis`, `comments` et `likes`.

### Ex02 - Seek_well

Travail sur les operations d'ecriture : insertion de timestamps, calcul des tours, mise a jour des noms et suppression du dernier passage.

### Ex03 - Tweetos aka Hello Rails

Approfondissement des modeles avec des methodes metier et des scopes, par exemple pour calculer la popularite d'un utilisateur ou classer les cuicuis.

### Ex04 - Seek_well

Travail sur la lecture des donnees : jointures, tris et affichage des resultats par nom ou par course.

### Ex05 - Tweetos aka Hello Rails

Mise en place de l'interface web CRUD avec routes, controleurs, vues et formulaires sur les ressources du projet.

### Ex06 - Seek_well

Consolidation du cycle complet en SQL brut : creation, insertion, mise a jour, suppression et lecture dans une petite application complete.

### Ex07 - Tweetos aka Hello Rails

Renforcement de la couche metier dans les modeles : statistiques, scopes reutilisables, validations personnalisees et requetes plus riches.

### Ex08 - Seek_well

Accent sur l'observation du comportement SQL depuis l'interface Rails : les actions utilisateur permettent de verifier directement l'etat courant de la base.

### Ex09 - Tweetos aka Hello Rails

Synthese de la branche Tweetos : schema, seed, validations, associations, logique metier et interface CRUD sont reunis dans une application coherente.

### Ex10 - Seek_well

Synthese de la branche SQL brut : toute la logique de manipulation de la base est visible et testable presque ligne par ligne.

## Ce que le module fait travailler

- modelisation relationnelle
- creation de schema SQL
- requetes `CREATE`, `INSERT`, `UPDATE`, `DELETE`, `SELECT`
- jointures et tris
- migrations Rails
- validations ActiveRecord
- associations entre modeles
- construction d'une interface web autour de la base

## Organisation du depot

- chaque dossier `exNN` contient un exercice autonome
- chaque exercice possede maintenant son propre `README.md`
- les README locaux expliquent le but, les concepts travailles et les aboutissants de l'exercice

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

## Note

La principale adaptation pratique par rapport au sujet d'origine est l'utilisation de Docker a la place d'une VM pour executer les projets.
