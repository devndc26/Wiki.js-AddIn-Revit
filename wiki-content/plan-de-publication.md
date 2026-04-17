# Plan de publication dans Wiki.js

## Objectif

Cette page propose une structure simple à reproduire dans Wiki.js pour obtenir un site clair et maintenable.

## Arborescence proposée

### Page d'accueil

- `/`

Contenu recommandé :

- résumé du projet ;
- accès rapide aux grandes rubriques ;
- mise en avant de l'installation et des fonctions principales.

### Section RevitAddin

- `/revitaddin/vue-d-ensemble`
- `/revitaddin/architecture`
- `/revitaddin/installation-addon`

### Sous-section Fonctions

- `/revitaddin/fonctions/vues`
- `/revitaddin/fonctions/nuage-de-points`
- `/revitaddin/fonctions/murs-et-ouvertures`
- `/revitaddin/fonctions/etiquetage-et-feuilles`
- `/revitaddin/fonctions/outils-de-suivi`

## Recommandations de mise en forme

- ajouter une page d'accueil avec des cartes ou des boutons vers les rubriques ;
- utiliser les icônes Wiki.js pour distinguer les zones métier ;
- réserver une rubrique technique pour les développeurs ;
- mettre à jour la documentation dès qu'une commande change côté code.

## Processus conseillé

1. lancer Wiki.js localement ;
2. créer la structure de pages selon les chemins proposés ;
3. copier le contenu Markdown du dossier `wiki-content/` ;
4. publier la page d'accueil en premier ;
5. relier les pages entre elles avec le menu ou les liens internes.