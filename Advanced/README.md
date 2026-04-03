# Advanced - Docker Version

Le sujet `Advanced.pdf` a ete realise en remplacant la contrainte "VM" par une execution Docker.

## Dossiers rendus

- `ex00/acme`
- `ex01/acme`
- `ex02/acme`
- `ex03/acme`
- `ex04/acme`
- `ex05/acme`
- `ex06/acme`

Chaque dossier contient une application Rails `acme` runnable avec Docker Compose et un `Makefile`.

## Utilisation

Depuis un dossier `ex0N/acme` :

```bash
make
```

ou

```bash
make all
```

Cela :

1. cree `.env` si besoin ;
2. build les conteneurs ;
3. recreate la base ;
4. lance les migrations ;
5. lance la seed ;
6. demarre l'application.

L'application est ensuite disponible sur :

- [http://localhost:3000](http://localhost:3000)

## Autres commandes

Depuis un dossier `ex0N/acme` :

```bash
make clean
make rubycritic
```

## Variables utiles

- `OWNER_LOGIN` pour afficher le login sur le site
- `CLOUDINARY_CLOUD_NAME`
- `CLOUDINARY_API_KEY`
- `CLOUDINARY_API_SECRET`

Sans configuration Cloudinary, CarrierWave utilise un stockage local pour le developpement.
