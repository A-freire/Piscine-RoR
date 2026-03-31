# Ex10 - Seek_well

## Objectif

Cet exercice peut se lire comme la synthese finale de la branche "SQL brut" du module : tout le pilotage de la base repose sur des requetes explicites et une interface Rails minimale.

## Ce que l'exercice met en place

- gestion complete du fichier SQLite
- creation et destruction du schema
- suivi de plusieurs courses
- historique des passages par coureur
- renommage, suppression ciblee et purge complete
- affichage ordonne selon plusieurs criteres

## Ce qu'il faut comprendre

Ex10 resume tres bien ce que le module veut faire toucher du doigt :

- une base est un etat persistant
- cet etat evolue via des requetes precises
- la qualite du schema conditionne la qualite des lectures
- les tris et jointures sont essentiels pour exploiter les donnees
- Rails peut etre utilise comme simple enveloppe d'execution autour de SQL pur

## Aboutissants de l'exercice

Au terme de cet exercice, tu dois etre capable de :

- concevoir et manipuler une petite base relationnelle sans ORM
- comprendre concretement les effets de `CREATE`, `INSERT`, `UPDATE`, `DELETE` et `SELECT`
- structurer une logique metier simple autour d'identifiants et d'historique
- debugger une application SQL en lisant la base et les tests
- faire le lien entre SQL brut et ce qu'ActiveRecord abstraira ensuite

## Fichiers importants

- `app/controllers/ft_query_controller.rb`
- `app/views/ft_query/index.html.erb`
- `test/controllers/ft_query_controller_test.rb`
- `ft_sql`

## Lancer l'exercice

```bash
bundle install
bin/rails server
bin/rails test
```

## En resume

Ex10 est l'aboutissement de Seek_well : une petite application complete pour comprendre, presque ligne par ligne, comment une base SQL vit derriere une interface web.
