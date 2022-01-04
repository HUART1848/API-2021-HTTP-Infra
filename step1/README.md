# Étape 1 - Serveur HTTP statique

## Introduction
Pour cette étape, j'ai fait le choix d'utiliser [nginx](https://nginx.org/) plutôt que [httpd](https://httpd.apache.org/).

Ayant déjà utilisé le serveur web Apache il y a longtemps mais jamais nginx, j'étais curieux de tester ce dernier.

## Dockerfile et autres scripts
Voici le contenu du fichier `Dockerfile`, on constate qu'il est très facile de créer une image avec un serveur nginx.
```dockerfile
FROM nginx

COPY src/ /usr/share/nginx/html
```
J'ai également créé 3 scripts, `build.sh`, `start.sh` et `reset.sh` qui permettent respectivement de créer l'image, créer et démarrer le container pour la première fois ainsi que de supprimer le container et l'image.

Afin d'éviter de multiplier les containers, je nomme le container 'step1' afin de pouvoir le démarrer et m'y connecter ultérieurement avec la commande `docker container start step1`. Cela permet aussi de vérifier facilement la persistance des modifications, p.ex en modifiant directement les fichiers de configuration de nginx ou les fichiers html du site dans le container.

## Autres choses à retenir

### Site statique
Comme on peut le déduire en lisant le `Dockerfile`, le contenu du site statique est situé dans `src/`.

J'ai fait le choix d'utiliser un template basé sur [Tailwind CSS](https://tailwindcss.com/) plutôt que Bootstrap.

Comme pour nginx et httpd, j'ai déjà utilisé Boostrap par le passé et j'étais curieux de voir à quoi ressemblait un site basé sur Tailwind.

### nginx vs httpd
Évidemment, nginx et httpd ne se configurent pas de la même manière.

Cependant je n'ai encore eu besoin de toucher aux fichiers de configurations de nginx dont voici la configuration principale par défaut située dans `/etc/nginx/nginx.conf` :
```
user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
```
Ainsi que la configuration http par défaut située dans `/etc/nginx/conf.d/default.conf`
```
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
```
On constate que nginx va servir le contenu du dossier `/usr/share/nginx/html/` sur le port 80

## Conclusion
J'ai constaté à quel point il est facile de créer un petit serveur web avec docker et nginx dans le cas présent. J'ai hâte d'utiliser ces outils pour les prochaines étapes du laboratoire.
