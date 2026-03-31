# Ex08 - Seek_well

## Objectif

Cet exercice met en valeur l'exploitation des donnees SQL dans une interface web simple, avec un accent sur la lisibilite des resultats et la verification du comportement de la base.

## Ce que l'exercice met en place

- boutons d'action pour piloter la base
- formulaires pour saisir ou renommer les coureurs
- affichage des passages en direct
- affichage global des resultats tries

## Ce qu'il faut comprendre

L'interet n'est pas seulement de faire marcher des requetes, mais aussi de rendre leur effet observable :

- l'utilisateur declenche une action
- la requete SQL modifie la base
- la vue Rails relit l'etat courant
- le rendu permet de verifier si la logique est correcte

Cet aller-retour entre action, base et affichage est central en developpement.

## Aboutissants de l'exercice

Tu dois etre capable de :

- expliquer comment une interface peut servir d'outil de debogage SQL
- relier un bouton de formulaire a une action de controleur et a une requete
- analyser un resultat de tri ou de jointure via l'affichage
- comprendre l'interet d'une visualisation immediate de l'etat courant
- valider un comportement base de donnees sans quitter l'application

## Fichiers importants

- `app/views/ft_query/index.html.erb`
- `app/controllers/ft_query_controller.rb`
- `test/controllers/ft_query_controller_test.rb`

## Lancer l'exercice

```bash
bundle install
bin/rails server
bin/rails test
```

## En resume

Ex08 montre l'aboutissement pratique du travail SQL : une interface minime, mais suffisante pour piloter, observer et verifier l'etat d'une base relationnelle.
