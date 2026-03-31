# Ex02 - Seek_well

## Objectif

Cet exercice pousse plus loin la manipulation SQL en travaillant surtout sur les operations de modification de donnees : insertion, mise a jour et suppression.

## Ce que l'exercice met en place

- demarrage d'une course avec creation d'une entree dans `race`
- insertion de nouveaux timestamps dans `clock_watch`
- calcul du tour suivant pour un coureur
- renommage d'un coureur deja enregistre
- suppression du dernier enregistrement

## Ce qu'il faut comprendre

Une base n'est pas seulement un stockage passif. Chaque action utilisateur modifie un etat coherent :

- une course a un identifiant
- chaque coureur enregistre plusieurs passages
- le numero de tour depend de l'historique deja present
- une mise a jour doit cibler les bonnes lignes

L'interet pedagogique est de voir comment une logique metier peut etre reconstruite uniquement avec du SQL et quelques traitements Ruby.

## Aboutissants de l'exercice

Apres cet exercice, tu dois pouvoir :

- ecrire une requete `INSERT` pertinente selon le contexte
- comprendre a quoi sert un `MAX(lap)` pour calculer le prochain tour
- voir la difference entre `DELETE` d'une ligne et purge complete d'une table
- comprendre les risques d'une requete `UPDATE` mal ciblee
- relier une action utilisateur a la requete SQL qui la traduit

## Fichiers importants

- `app/controllers/ft_query_controller.rb`
- `test/controllers/ft_query_controller_test.rb`
- `config/routes.rb`

## Lancer l'exercice

```bash
bundle install
bin/rails server
bin/rails test
```

## En resume

Ex02 apprend a faire vivre les donnees dans le temps. Le vrai sujet n'est plus seulement la structure, mais la maniere dont les lignes evoluent pendant une course.
