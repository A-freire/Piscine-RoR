# Ex03 - Tweetos aka Hello Rails

## Objectif

Cet exercice se concentre sur l'exploitation du modele relationnel avec ActiveRecord : associations utiles, methodes metier et premieres requetes "intelligentes".

## Ce que l'exercice met en place

- methodes metier dans `User`
- scope `Cuicui.top`
- calculs derives comme `fame`
- recuperation des reponses recentes d'un utilisateur
- classement des publications les plus populaires

## Ce qu'il faut comprendre

Le schema seul ne suffit pas. Une bonne application sait aussi exprimer la logique metier dans ses modeles :

- `fame` traduit une notion de popularite
- `responses` encapsule une requete avec jointure et tri
- `top_cuicui` et `Cuicui.top` montrent comment agregations et `JOIN` deviennent du code Rails lisible

Ici, on travaille l'idee qu'ActiveRecord n'est pas seulement un acces CRUD, mais aussi un langage de requetage metier.

## Aboutissants de l'exercice

Tu dois pouvoir :

- expliquer comment une jointure est exprimee en ActiveRecord
- comprendre l'utilite d'un `scope` pour reutiliser une requete
- lire un `group` ou un `order` et en deduire le resultat
- distinguer une association d'une methode metier derivee
- voir comment une logique SQL complexe peut rester centralisee dans les modeles

## Fichiers importants

- `app/models/user.rb`
- `app/models/cuicui.rb`
- `test/models/user_test.rb`
- `test/models/cuicui_test.rb`

## Lancer l'exercice

```bash
bundle install
bin/rails db:create db:migrate db:seed
bin/rails test
bin/rails server
```

## En resume

Ex03 fait passer le projet d'un simple schema valide a un vrai modele metier capable de calculer, filtrer et classer les donnees.
