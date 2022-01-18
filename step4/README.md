# Étape 4 - AJAX

## Introduction
Pour cette étape, j'ai repris les images et configurations des étapes précédentes.

J'utilise une nouvelle image `ajax-http` qui est une modification de l'image du serveur web statique. Le nouveau code de la page se situe dans `src/`. Les modifications comprennent notamment l'ajout de JQuery et d'un fichier `index.js` effectuant une requête AJAX. 

La configuration du proxy inverse a été légèrement modifiée en conséquence.

## Dockerfile et autres scripts
Voici le contenu du `Dockerfile`, identique à celui de l'étape 1.
```dockerfile
FROM nginx

COPY src/ /usr/share/nginx/html
```
Dans le dossier `scripts/` on retrouve 5 scripts:
`build.sh`, `start-ajax.sh`, `start-dynamic.sh`, `start-proxy.sh` et `get-addresses.sh` qui permettent respectivement de créer l'image, lancer le serveur effectuant la requête ajax, lancer le serveur dynamique, lancer le proxy inverse et obtenir les adresses IP internes des deux serveurs web.

N.B: Lancer les scripts depuis la racine du dossier `step4` avec `sh scripts/nom_du_script.sh` ou `./scripts/nom_du_script.sh`.

Tous les containers sont lancés en mode 'oneshot' avec l'option `--rm`.

## Autres choses à retenir

### Utilité du proxy inverse
Dans le fichier `index.js`, on remarque que la requête AJAX se fait sur un chemin relatif `/dynamic/`. Cela fait sens depuis la perspective du client (perspective d'exécution du script), vu que les deux serveurs apparaissent comme "un seul" sur une seule adresse grâce au proxy inverse.

Cela permet également d'être conforme au principe de 'Same-origin policy'.

## Conclusion
Cette étape a pu clairement démontrer l'utilité d'un proxy inverse pour effectuer des requêtes AJAX.
