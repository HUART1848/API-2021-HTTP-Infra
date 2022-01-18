# Étape 5 - Proxy inverse dynamique

## Introduction
Pour cette étape, j'ai repris les images et configurations des étapes précédentes.

J'utilise une nouvelle image `reverse-proxy:dynamic` qui est basée sur l'image `reverse-proxy` créée précédemment. Les IP "en dur" on été remplacées par des noms dans le fichier `conf/default.conf`, ce qui permet une configuration dynamique. La configuration n'est également plus montée à l'aide d'un volume au dernier moment mais copiée à la création de l'image.

J'utilise également [Docker Compose](https://docs.docker.com/compose/), qui permet de lancer facilement les différents containers et de leur attribuer des noms DNS internes qui sont nécessaires pour la configuration dynamique.

## Dockerfile et autres scripts
Voici le contenu du fichier `docker-compose.yml`.
```yaml
version: "3.9"
services:
  ajax:
    container_name: ajax_http
    image: ajax-http
  dynamic:
    container_name: dynamic_http
    image: dynamic-http
  proxy:
    container_name: reverse_proxy
    image: reverse-proxy:dynamic
    ports:
      - "8080:80"
```
ainsi que du `Dockerfile`.
```dockerfile
FROM nginx

COPY conf/default.conf /etc/nginx/conf.d/default.conf

COPY includes/ /etc/nginx/includes/
```
Dans le dossier `scripts/` on retrouve 2 scripts:
`build.sh` et `get-addresses.sh` qui permettent respectivement de créer l'image du nouveau proxy inverse et obtenir les adresses des serveurs.

N.B: Lancer les scripts depuis la racine du dossier `step5` avec `sh scripts/nom_du_script.sh` ou `./scripts/nom_du_script.sh`.

## Autres choses à retenir

### Images locales et Docker Compose
J'ai constaté qu'il faut bien s'assurer d'avoir construit les images locales au préalable avant de lancer les containers, sinon Docker Compose va essayer de les 'pull' depuis internet et cela ne va pas fonctionner.

## Conclusion
Cette étape a montré l'utilité de Docker Compose pour déployer facilement des (petites) infrastructures dynamiques sous forme de containers.
