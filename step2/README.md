# Étape 2 - Serveur HTTP dynamique

## Introduction
Pour cette étape, j'ai fait le choix d'utiliser le language [Julia](https://julialang.org) et son package [HTTP.jl](https://juliaweb.github.io/HTTP.jl/stable/) pour créer un petit serveur HTTP servant du contenu dynamique.

## Dockerfile et autres scripts
Voici le contenu du `Dockerfile`. L'image est basée sur l'image officielle de Julia. 
```dockerfile
FROM julia:alpine

COPY src/ /opt/app/

RUN julia -e 'using Pkg;Pkg.add(["HTTP", "JSON"])'

CMD ["julia", "/opt/app/main.jl"]
```
On installe les packages **HTTP** et **JSON** nécessaires au fonctionnement du programme, qui se situe dans le fichier `main.jl` et qui contient le code du serveur.

Il y a 2 scripts, `build.sh` et `start.sh` qui permettent respectivement de créer l'image et de démarrer un conteneur basée sur cette dernière. Pour éviter de multiplier les conteneurs, le script de lancement comprend l'option `--rm` qui permet de démarrer le serveur en mode 'oneshot'.

N.B: Lancer les scripts depuis la racine du dossier `step2` avec `sh scripts/nom_du_script.sh` ou `./scripts/nom_du_script.sh`.

## Autres choses à retenir

### Contenu dynamique
Le serveur fournit des informations aléatoires à propos de chats (race, age et activité en cours) sous forme de JSON.

J'ai utilisé Postman pour vérifier avec succès les réponses aux requêtes.

### 127.0.0.1 ou 0.0.0.0 ?
En réalisant cette étape, j'ai pu voir la différence entre les adresses `127.0.0.1` et `0.0.0.0` comme le résume bien cet [article](https://www.howtogeek.com/225487/what-is-the-difference-between-127.0.0.1-and-0.0.0.0/). En effet, j'avais dans un premier temps utilisé l'adresse `127.0.0.1` comme adresse d'écoute du serveur, ce qui fonctionnait bien en lançant le serveur sur ma machine mais plus du tout une fois dans le conteneur.

Cela vient du fait que les requêtes arrivent sur l'adresse IP propre du conteneur, ce qui n'est pas la même chose que du `localhost` vers `localhost` (comme quand on lance et accède directement en local). Cette adresse propre n'étant pas forcément connue, `0.0.0.0` permet de regarder sur n'importe quelle adresse du conteneur (si l'adresse était fixe, on pourrait la spécifier comme adresse à écouter plutôt que `0.0.0.0`).

## Conclusion
C'était très intéressant d'utiliser Julia pour créer un serveur HTTP dynamique, puis de dockeriser cette implémentation.
