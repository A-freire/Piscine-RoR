# Ex04 - Seek_well

## Objectif

Cet exercice met l'accent sur la lecture de donnees et la restitution de resultats exploitables, en particulier avec des tris et des jointures entre tables.

## Ce que l'exercice met en place

- affichage des timestamps bruts
- affichage complet des resultats d'une course
- tri par nom de coureur
- tri par numero de course
- jointure entre `clock_watch` et `race`

## Ce qu'il faut comprendre

Une base relationnelle prend tout son sens quand on recolle plusieurs tables pour produire une vue metier lisible. Ici :

- `clock_watch` contient l'historique detaille
- `race` contient le depart de chaque course
- le `JOIN` permet d'afficher les passages avec leur contexte de course

Le tri change la lecture du resultat :

- tri par nom pour suivre un coureur
- tri par course pour suivre l'ordre chronologique des evenements

## Aboutissants de l'exercice

Apres cet exercice, tu dois savoir :

- pourquoi on separe stockage et affichage
- quand il faut faire un `JOIN`
- comment `ORDER BY` change l'analyse des donnees
- produire une sortie SQL exploitable par une interface web
- expliquer la difference entre une table source et une vue logique reconstituee

## Fichiers importants

- `app/controllers/ft_query_controller.rb`
- `app/views/ft_query/index.html.erb`
- `app/views/ft_query/_all.html.erb`
- `app/views/ft_query/_timestamp.html.erb`

## Lancer l'exercice

```bash
bundle install
bin/rails server
bin/rails test
```

## En resume

Ex04 apprend a relire proprement une base relationnelle et a transformer des lignes SQL en information comprehensible pour l'utilisateur.
