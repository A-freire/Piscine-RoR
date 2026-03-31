# Ex06 - Seek_well

## Objectif

Cet exercice sert de consolidation sur le SQL brut : structure, ecriture, mise a jour, suppression et lecture sont reunies dans un meme petit outil de suivi de course.

## Ce que l'exercice met en place

- creation et destruction de la structure SQL
- enregistrement de courses et de passages
- calcul progressif des tours
- affichage des donnees selon plusieurs points de vue
- remise a zero de l'etat

## Ce qu'il faut comprendre

Ici, l'important est la chaine complete :

1. creer le support de stockage
2. structurer les tables
3. inserer des donnees coherentes
4. les corriger si besoin
5. les lire avec des tris adaptes
6. nettoyer la base

Cet exercice est utile pour ancrer les bases SQL avant de s'appuyer sur des abstractions plus haut niveau.

## Aboutissants de l'exercice

Si tu sais refaire l'exercice, tu sais en pratique :

- piloter une base SQLite depuis une application Ruby
- concevoir un mini schema relationnel simple
- maintenir la coherence des identifiants de course et des tours
- faire du CRUD sans ORM
- verifier le resultat d'une action en lisant directement les lignes en base

## Fichiers importants

- `app/controllers/ft_query_controller.rb`
- `test/controllers/ft_query_controller_test.rb`
- `ft_sql`

## Lancer l'exercice

```bash
bundle install
bin/rails server
bin/rails test
```

## En resume

Ex06 est une etape de consolidation : l'objectif n'est plus seulement de connaitre les ordres SQL, mais de savoir les enchainer proprement dans une petite application complete.
