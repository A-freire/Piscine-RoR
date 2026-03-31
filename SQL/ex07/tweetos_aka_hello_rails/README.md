# Ex07 - Tweetos aka Hello Rails

## Objectif

Cet exercice approfondit la couche modele en ajoutant des notions de classement, de statistiques et de regles metier sur un schema relationnel deja fonctionnel.

## Ce que l'exercice met en place

- scopes reutilisables
- methodes metier sur `User` et `Cuicui`
- validations plus strictes
- associations exploitees pour repondre a des questions metier concretes

## Ce qu'il faut comprendre

Dans une application Rails, le modele n'est pas seulement un reflet passif des tables. Il doit exprimer :

- des contraintes metier
- des comportements
- des raccourcis de requetage
- des statistiques lisibles

Des methodes comme `fame`, `responses` ou `top_cuicui` montrent comment emballer des requetes utiles dans une API orientee domaine.

## Aboutissants de l'exercice

Tu dois pouvoir :

- concevoir une methode metier qui repose sur plusieurs tables
- factoriser une requete recurrente dans un scope
- justifier une validation personnalisee
- comprendre comment une statistique applicative repose sur des aggregations SQL
- maintenir un modele lisible malgre une logique de requete deja un peu riche

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
```

## En resume

Ex07 montre comment transformer un schema valide en un domaine applicatif expressif, capable de raconter quelque chose sur les donnees et pas seulement de les stocker.
