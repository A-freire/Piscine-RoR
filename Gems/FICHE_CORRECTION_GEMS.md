# Fiche rapide - Correction Gems (Piscine RoR)

Objectif: mémo court pour réexpliquer le projet dans quelques semaines.

## Arborescence rendue
- `Gems/ex00/deepthought`
- `Gems/ex01/ft_wikipedia`
- `Gems/ex02/Taillste`
- `Gems/ex03/HelloWorld`

---

## Ex00 - deepthought

### Ce que fait la gem
- Classe `Deepthought` avec méthode `respond(question)`.
- Si question exacte:
  - `"The Ultimate Question of Life, the Universe and Everything"`
  - affiche `42` en vert et retourne `"42"`.
- Sinon:
  - affiche `"Mmmm i 'm bored"` en rouge et retourne cette string.

### Fichiers importants
- `lib/deepthought.rb`: logique métier.
- `lib/deepthought/version.rb`: version (`0.0.1`).
- `deepthought.gemspec`: nom gem + licence MIT + dépendance `colorize`.
- `test/deepthought_test.rb`: tests demandés.

### Pourquoi fichier version séparé
- Pattern RubyGems standard.
- Une seule source de vérité pour la version.
- Chargée via `require_relative "deepthought/version"`.

### Tests à montrer au correcteur
```bash
cd Gems/ex00/deepthought
bundle exec rake
```
Résultat attendu: `0 failures, 0 errors`.

### Test manuel rapide
```bash
cd Gems/ex00/deepthought
bundle exec ruby -I lib -e 'require "deepthought"; d=Deepthought.new; p d.respond("The Ultimate Question of Life, the Universe and Everything"); p d.respond("Salut")'
```

### Point PDF validés
- Nom gem: `deepthought`
- Minitest
- Licence MIT
- Version `0.0.1`
- `colorize` utilisé
- test `Deepthought.new`
- test des 2 cas de `respond`
- `grep TODO` vide

---

## Ex01 - ft_wikipedia

### Ce que fait la gem
- `Ft_wikipedia.search("..." )`
- Part d’une page Wikipedia EN.
- Suit le premier lien valide de la première description.
- Affiche les URLs visitées.
- Retourne le nombre d’étapes avant `/wiki/Philosophy`.

### Cas gérés
- Boucle détectée -> message `Loop detected ...` + retour `nil`.
- Impasse (aucun lien valide) -> `Dead end page reached` + retour `nil`.

### Règles de lien validé
- doit commencer par `/wiki/`
- pas de `:` (évite fichiers/aide)
- pas de `#` (ancre)

### Fichiers importants
- `lib/ft_wikipedia.rb`: logique parsing + navigation.
- `test/ft_wikipedia_test.rb`: tests (kiss, matter, directory, problem, einstein, dead-end).

### Tests à montrer
```bash
cd Gems/ex01/ft_wikipedia
bundle exec rake
```

---

## Ex02 - Taillste (TDD)

### Idée de l’exercice
- Les tests sont fournis.
- Il faut déduire le comportement et implémenter le code pour les faire passer.

### Ce qui a été implémenté
- `Taillste::Drum`
- `Taillste::Beat_box < Drum`
- `Taillste::Clap < Drum`
- Méthodes: `beat`, `shuffle`, `count`, `played_with`.

### Fichiers importants
- `lib/taillste.rb`: implémentation complète.
- `test/test_taillste.rb`: tests de référence (16 tests).

### Vérifications demandées dans le PDF
```bash
cd Gems/ex02/Taillste
gem build taillste.gemspec
bundle exec rake
```
Dernière ligne attendue:
`16 runs, 16 assertions, 0 failures, 0 errors, 0 skips`

---

## Ex03 - Rails HelloWorld

### Ce qui a été fait
- Gem `rails` installée.
- App Rails créée: `Gems/ex03/HelloWorld`.
- Route racine (`/`) vers `home#index`.
- Vue affiche `<h1>Hello World!</h1>`.

### Fichiers importants
- `config/routes.rb`: `root "home#index"`
- `app/controllers/home_controller.rb`
- `app/views/home/index.html.erb`

### Démo correcteur
```bash
cd Gems/ex03/HelloWorld
bundle install
bin/rails s
```
Puis ouvrir `http://localhost:3000/`.

---

## Pitch oral court (30s)
- Ex00: j’ai créé une gem simple `deepthought` avec `colorize`, versionnée, testée en minitest.
- Ex01: j’ai créé une gem qui suit les liens Wikipedia jusqu’à Philosophy, avec gestion boucle et dead-end + tests dédiés.
- Ex02: j’ai fait du TDD inversé: j’ai lu les tests existants et implémenté le code pour obtenir 16/16 assertions vertes + gem build OK.
- Ex03: j’ai installé Rails et généré une app dont la page d’accueil affiche `Hello World!` dans un `<h1>`.

---

## Checklist avant soutenance
- Relancer tous les tests:
```bash
cd Gems/ex00/deepthought && bundle exec rake
cd ../../ex01/ft_wikipedia && bundle exec rake
cd ../../ex02/Taillste && gem build taillste.gemspec && bundle exec rake
```
- Vérifier Rails:
```bash
cd ../../ex03/HelloWorld && bin/rails s
```
- Vérifier ex00 TODO:
```bash
cd ../../ex00/deepthought && grep -Hrn 'TODO' --color=always .
```
(Doit ne rien retourner.)
