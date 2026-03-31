# Ex00 - Seek_well

## Objectif

Cet exercice sert d'introduction a la manipulation d'une base SQLite sans passer par ActiveRecord. L'idee est de piloter la base "a la main" depuis Rails avec des requetes SQL explicites.

## Ce que l'exercice met en place

- creation d'un fichier SQLite `ft_sql`
- creation de deux tables :
  - `race`
  - `clock_watch`
- lancement d'une course avec 4 participants
- insertion de nouveaux tours
- suppression du dernier point de passage
- vidage complet des donnees

## Ce qu'il faut comprendre

Ici, Rails ne sert pas a gerer le schema. Il sert surtout d'interface HTTP et HTML, tandis que toute la logique de persistence repose sur `SQLite3::Database` et des requetes `CREATE`, `INSERT`, `UPDATE`, `DELETE` et `SELECT`.

La table `race` represente une course. La table `clock_watch` stocke chaque passage d'un coureur avec la date, l'heure, le numero de course et le numero de tour.

## Aboutissants de l'exercice

Si l'exercice est compris, tu dois etre capable de :

- expliquer la difference entre creer une base, creer des tables et inserer des lignes
- lire un schema SQL simple
- comprendre pourquoi `race` et `clock_watch` sont separees
- suivre l'evolution d'un etat applicatif uniquement avec des requetes SQL
- voir que Rails peut servir de couche d'affichage meme quand la base est geree "a la main"

## Fichiers importants

- `app/controllers/ft_query_controller.rb`
- `app/views/ft_query/index.html.erb`
- `config/routes.rb`
- `ft_sql`

## Lancer l'exercice

```bash
bundle install
bin/rails server
```

Ensuite, ouvre l'application et utilise les boutons dans cet ordre :

1. `db_creation`
2. `table_creation`
3. `Subscribe / Start race`
4. `time`, `update name`, `Show all by name`, `Show all by race`

## En resume

Ex00 pose la base du module : comprendre le cycle de vie d'une base SQL et voir concretement comment une application ecrit et relit ses donnees.
