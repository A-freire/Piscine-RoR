# Ex09 - Tweetos aka Hello Rails

## Objectif

Cet exercice correspond a une version integree du projet Tweetos : schema, validations, associations, logique metier, seed de donnees et interface CRUD sont reunis dans une seule application.

## Ce que l'exercice met en place

- base de donnees complete
- reseau de relations entre utilisateurs, messages, commentaires et likes
- donnees de seed pour tester l'application
- pages CRUD pour manipuler les ressources
- methodes metier pour mesurer l'activite et la popularite

## Ce qu'il faut comprendre

Cet exercice fait la synthese entre SQL et Rails :

- SQL pour penser la structure et les relations
- ActiveRecord pour encapsuler les requetes metier
- Rails pour exposer le tout via une interface web

La valeur pedagogique est de voir qu'une application n'est pas une somme de fichiers separes, mais un systeme coherent ou schema, logique et affichage se repondent.

## Aboutissants de l'exercice

Si l'exercice est bien compris, tu peux :

- expliquer tout le cycle de vie d'une donnee, de sa creation a son affichage
- justifier le schema relationnel choisi
- comprendre comment les seeds servent a tester rapidement une application
- lire une petite application Rails de bout en bout
- distinguer ce qui releve du stockage, du metier et de la presentation

## Fichiers importants

- `db/migrate/*`
- `db/seeds.rb`
- `app/models/*`
- `app/controllers/*`
- `app/views/*`

## Lancer l'exercice

```bash
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
bin/rails test
```

## En resume

Ex09 est l'aboutissement de la branche Tweetos : une mini application sociale complete, suffisante pour comprendre comment SQL et Rails s'articulent dans un projet reel.
