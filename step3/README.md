# Étape 3 - Proxy inverse

## Introduction
Pour cette étape, j'ai fait le choix d'utiliser nginx plutôt que Apache. Nginx étant réputé comme outil de proxy inverse, j'étais curieux d'essayer cette fonctionnalité.

Le proxy inverse permet d'accéder à deux serveurs (un serveur statique et un serveur dynamique) qui sont ceux des étapes [1](../step1/) et [2](../step2/).

## Dockerfile et autres scripts
Voici le contenu du `Dockerfile`. L'image est basée sur l'image officielle de nginx. 
```dockerfile
FROM nginx

COPY includes/ /etc/nginx/includes/
```
On copie la configuration des options du proxy inverse. On ne copie pas encore la configuration globale du serveur, car celle-ci dépend des adresses IP des deux serveurs web servis par le proxy inverse. Ces adresses pouvant varier, le fait de copier la configuration au dernier moment (via un volume) permet d'adapter celle-ci en conséquence.

Dans le dossier `scripts/` on retrouve 5 scripts:
`build.sh`, `start-static.sh`, `start-dynamic.sh`, `start-proxy.sh` et `get-addresses.sh` qui permettent respectivement de créer l'image, lancer le serveur statique, lancer le serveur dynamique, lancer le proxy inverse et obtenir les adresses IP internes des deux serveurs web.

N.B: Lancer les scripts depuis la racine du dossier `step3` avec `sh scripts/nom_du_script.sh` ou `./scripts/nom_du_script.sh`.

Tous les containers sont lancés en mode 'oneshot' avec l'option `--rm`.

## Autres choses à retenir

### Configuration du proxy inverse
Cette [marche à suivre](https://phoenixnap.com/kb/docker-nginx-reverse-proxy) a été très utile pour implémenter le proxy inverse avec nginx. En regardant le fichier de configuration (`conf/default.conf`), on constate qu'il est très simple de matcher une URL vers un serveur tiers.

J'ai également pu constater qu'il est très important d'ajouter un `/` dans les URL de la configuration comme expliqué [ici](https://stackoverflow.com/questions/16157893/nginx-proxy-pass-404-error-dont-understand-why).

Étant donné que les containers des deux serveurs web ne sont pas lancés avec un mappage de port, la seule manière d'y accéder depuis l'extérieur est bien de passer par le proxy inverse, comme demandé dans la consigne.

## Conclusion
J'ai trouvé très intéressant de configurer nginx comme proxy inverse. La configuration est cependant fragile, les adresses IP étant paramétrées "en dur", cela reste un proxy inverse simple mais peu robuste.
