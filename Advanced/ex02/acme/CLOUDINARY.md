# Cloudinary pour l'exercice 02

L'exercice 02 demande explicitement l'utilisation de Cloudinary pour les images.

## Etat actuel

Dans cette application :

- si les 3 variables Cloudinary sont renseignees, CarrierWave envoie les images vers Cloudinary ;
- les images du catalogue utilisent alors des URLs Cloudinary transformees ;
- les miniatures sont demandees avec :
  - `width`
  - `height`
  - `crop: fill`
  - `gravity: auto`
  - `fetch_format: auto`
  - `quality: auto`

Si les variables ne sont pas renseignees, l'application repasse en stockage local uniquement pour le developpement.

## Variables a renseigner

Dans `.env` :

```env
CLOUDINARY_CLOUD_NAME=ton_cloud_name
CLOUDINARY_API_KEY=ta_api_key
CLOUDINARY_API_SECRET=ton_api_secret
```

## Comment tester

1. Cree ton compte gratuit Cloudinary.
2. Recupere les 3 credentials.
3. Mets-les dans [ex02/acme/.env](/Users/bexas/Repo/Piscine-RoR/Advanced/ex02/acme/.env).
4. Lance :

```bash
cd /Users/bexas/Repo/Piscine-RoR/Advanced/ex02/acme
make clean
make
```

5. Connecte-toi avec :
   - `admin@gmail.com`
   - `password`
6. Cree une marque ou un produit avec une image.
7. Verifie dans le HTML ou l'inspecteur que l'URL de l'image pointe vers `res.cloudinary.com`.

## Verification rapide en console

Tu peux verifier si Cloudinary est active avec :

```bash
docker compose run --rm web bundle exec rails runner 'puts ApplicationUploader.cloudinary_configured?'
```

Resultat attendu si tout est bien configure :

```ruby
true
```
