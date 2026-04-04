# Final - Guide de correction

Ce depot reprend le sujet `Final` de la piscine Ruby on Rails, adapte pour Docker au lieu d'une VM.

## Structure

- `ex00` a `ex03`: application `Xnote`
- `ex04` a `ex06`: application `Chat`

Chaque exercice contient sa propre application Rails et son propre `Makefile`.

## Commandes utiles

Depuis le dossier de l'exercice voulu:

```bash
cd ex00
make run
```

Commandes disponibles dans chaque exercice:

- `make run`: build puis lance l'application
- `make interactive`: ouvre un shell dans le conteneur
- `make clean`: supprime conteneurs, image Docker, volume bundle et ressources associees

Ports utilises:

- `Xnote` (`ex00` a `ex03`): [http://localhost:3000](http://localhost:3000)
- `Chat` (`ex04` a `ex06`): [http://localhost:3001](http://localhost:3001)

## Premier lancement

Si tu veux preparer la base avant la correction:

```bash
cd ex00
make interactive
bundle exec rails db:prepare
exit
make run
```

Meme logique pour `ex04`, `ex05` et `ex06`.

## Remise a zero

`make clean` ne supprime pas la base SQLite du projet. Si tu veux repartir d'un etat vide:

Pour `Xnote`:

```bash
rm -f ex00/Xnote/db/development.sqlite3
cd ex00
make interactive
bundle exec rails db:prepare
exit
```

Pour `Chat`:

```bash
rm -f ex04/Chat/db/development.sqlite3
cd ex04
make interactive
bundle exec rails db:prepare
exit
```

## Correction Xnote

Regle generale pour `ex00` a `ex03`:

- ouvrir l'application sur `http://localhost:3000`
- verifier que le `Refresh count` reste a `1`
- montrer que les actions se font sans rechargement complet de page

### ex00 - Francis_1

Lancement:

```bash
cd ex00
make run
```

Ce qu'il faut montrer:

1. Cliquer sur `Add a book` fait apparaitre le formulaire en AJAX.
2. Ajouter un livre avec un nom unique met a jour la liste et masque le formulaire.
3. Tenter d'ajouter deux fois le meme nom affiche une erreur de validation.
4. Le `Refresh count` reste a `1`.

### ex01 - Francis_2

Lancement:

```bash
cd ex01
make run
```

Ce qu'il faut montrer:

1. Ajouter un ou deux livres.
2. Cliquer sur `Delete` ouvre bien la confirmation.
3. Apres confirmation, le livre disparait sans rechargement complet.
4. Le `Refresh count` reste a `1`.

### ex02 - Francis_3

Lancement:

```bash
cd ex02
make run
```

Ce qu'il faut montrer:

1. Cliquer sur `Edit` remplace la ligne du livre par un formulaire inline.
2. Modifier un livre avec un nom libre fonctionne sans reload.
3. Tenter de renommer un livre avec un nom deja pris affiche l'erreur directement dans la ligne.
4. Le `Refresh count` reste a `1`.

### ex03 - Francis_4

Lancement:

```bash
cd ex03
make run
```

Ce qu'il faut montrer:

1. Le compteur `Total books` est visible en haut de page.
2. Ajouter un livre incremente le compteur sans reload complet.
3. Supprimer un livre decremente le compteur sans reload complet.
4. Modifier un livre ne casse pas le compteur.
5. Le `Refresh count` reste a `1`.

## Correction Chat

Regle generale pour `ex04` a `ex06`:

- ouvrir deux clients: un navigateur normal et une fenetre privee
- creer au moins deux comptes differents
- se connecter avec deux utilisateurs differents
- verifier les comportements temps reel entre les deux clients

### ex04 - ChatOne

Lancement:

```bash
cd ex04
make run
```

Ce qu'il faut montrer:

1. Un utilisateur non connecte arrive sur la page d'accueil avec `Sign in` et `Sign up`.
2. Deux utilisateurs distincts se connectent.
3. Les messages du chat apparaissent en temps reel sur les deux clients.
4. Le salon partage est bien commun aux utilisateurs connectes.
5. Les diffusions passent par Action Cable et un job Rails (`MessageBroadcastJob`), ce qui sert de tampon pour le temps reel.

### ex05 - ChatTwo

Lancement:

```bash
cd ex05
make run
```

Ce qu'il faut montrer:

1. Un utilisateur connecte peut creer une `ChatRoom`.
2. Le createur de la salle est bien memorise.
3. Un message envoye dans une salle n'apparait pas dans une autre salle.
4. Le bouton `Delete room` n'apparait que pour le createur.
5. Supprimer une salle supprime aussi ses messages.

Preuve complementaire si l'evaluateur veut verifier la dependance utilisateur -> salles -> messages:

```bash
cd ex05
make interactive
bundle exec rails console
```

Puis dans la console Rails:

```ruby
user = User.find_by(email: "email_du_createur@example.com")
user.destroy
```

Ensuite, verifier dans l'interface que les salles creees par cet utilisateur et leurs messages ont disparu.

### ex06 - ChatThree

Lancement:

```bash
cd ex06
make run
```

Ce qu'il faut montrer:

1. Garder deux utilisateurs connectes en meme temps.
2. Quand l'utilisateur A envoie un message, l'utilisateur B recoit une notification en temps reel.
3. Le compteur de notifications augmente immediatement.
4. Aucune notification n'est creee pour l'auteur de son propre message.
5. La notification apparait meme si l'autre utilisateur n'est pas sur la meme page de discussion.
6. Un son est joue a la reception d'une nouvelle notification.

## Points techniques utiles a dire a l'oral

- `Xnote` repose sur Rails UJS et les reponses `*.js.erb` pour mettre a jour l'interface sans recharger toute la page.
- `Chat` utilise `Devise` pour l'authentification.
- Le temps reel passe par `Action Cable`.
- Les broadcasts passent par des jobs Rails pour eviter de faire tout le travail directement dans la requete web.
- `ex04` a `ex06` utilisent Redis dans Docker pour Action Cable.

## Ordre de passage conseille

Si tu veux aller vite pendant la correction:

1. `ex00`: creation AJAX + erreur d'unicite
2. `ex01`: suppression AJAX
3. `ex02`: edition inline AJAX
4. `ex03`: compteur mis a jour
5. `ex04`: chat temps reel multi-client
6. `ex05`: salles isolees + proprietaire
7. `ex06`: notifications temps reel + compteur + son
