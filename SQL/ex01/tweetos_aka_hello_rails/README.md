# Ex01 - Tweetos aka Hello Rails

## Objectif

Cet exercice introduit la modelisation relationnelle avec Rails et ActiveRecord a travers un mini reseau social compose de `users`, `cuicuis`, `comments` et `likes`.

## Ce que l'exercice met en place

- migrations pour creer le schema
- validations sur les modeles
- associations entre les entites
- premiere structure CRUD exposee par Rails

## Ce qu'il faut comprendre

Le coeur de l'exercice est de transformer un besoin metier simple en schema relationnel coherent :

- un `User` publie des `Cuicui`
- un `User` peut commenter un `Cuicui`
- un `User` peut liker un `Cuicui`

On apprend aussi a proteger les donnees avec des validations :

- unicite de `name` et `email`
- format d'email
- presence des champs importants
- coherence des cles etrangeres

## Aboutissants de l'exercice

Si l'exercice est maitrise, tu dois etre capable de :

- expliquer pourquoi une relation `has_many` ou `belongs_to` existe
- lire une migration et comprendre le schema genere
- distinguer validation applicative et structure de table
- justifier la presence des indexes sur les colonnes souvent recherchees
- decrire comment un mini reseau social se traduit en tables SQL

## Fichiers importants

- `db/migrate/*`
- `db/schema.rb`
- `app/models/user.rb`
- `app/models/cuicui.rb`
- `app/models/comment.rb`
- `app/models/like.rb`

## Lancer l'exercice

```bash
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
bin/rails test
```

## En resume

Ex01 pose les fondations du projet Tweetos : le schema, les regles de validation et les associations de base entre les donnees.
