# Ex05 - Tweetos aka Hello Rails

## Objectif

Cet exercice relie enfin le modele de donnees a une vraie interface Rails avec routes, controleurs, vues et formulaires CRUD.

## Ce que l'exercice met en place

- routes REST pour `users`, `cuicuis`, `comments` et `likes`
- controleurs scaffoldes
- vues HTML pour lister, afficher, creer, modifier et supprimer
- page racine sur les utilisateurs

## Ce qu'il faut comprendre

Le point cle est de voir comment le modele SQL/ActiveRecord devient une application navigable :

- les routes exposent les actions HTTP
- les controleurs recuperent ou modifient les donnees
- les vues affichent le resultat
- les formulaires soumettent des parametres filtres par les strong params

Autrement dit, on quitte le seul raisonnement base de donnees pour comprendre le cycle complet d'une requete web.

## Aboutissants de l'exercice

Tu dois pouvoir :

- expliquer le role respectif d'une route, d'un controleur et d'une vue
- suivre une creation d'objet depuis le formulaire jusqu'a la base
- comprendre l'utilite des `before_action`
- lire une action `create`, `update` ou `destroy`
- voir comment le modele relationnel devient une interface d'administration

## Fichiers importants

- `config/routes.rb`
- `app/controllers/users_controller.rb`
- `app/controllers/cuicuis_controller.rb`
- `app/controllers/comments_controller.rb`
- `app/controllers/likes_controller.rb`

## Lancer l'exercice

```bash
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
```

Puis ouvre la racine de l'application pour naviguer dans les ressources.

## En resume

Ex05 montre l'aboutissement naturel du travail precedent : une base bien modelee devient une application web exploitable.
