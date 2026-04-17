---
layout: default
title: Murs et Ouvertures
parent: Fonctions
nav_order: 3
---

# Fonctions des panneaux Murs et Ouvertures

Ces commandes visent à accélérer la création de types à partir de mesures prises directement dans Revit.

## Créer Type Mur

### But

Créer ou réutiliser un type de mur selon une épaisseur mesurée entre deux points.

### Utilité

Cette commande sert à produire rapidement un type cohérent avec l'existant ou avec une mesure relevée, sans ressaisir manuellement toute la structure du type.

### Fonctionnement

1. sélection de deux points ;
2. calcul de la distance XY ;
3. recherche d'un type correspondant ;
4. création ou réutilisation du type ;
5. mise à jour de l'épaisseur de la première couche de coeur.

---

## Créer Type Porte

### But

Créer ou réutiliser un type de porte à partir d'une largeur et d'une hauteur mesurées en trois clics.

### Fonctionnement

1. deux clics pour la largeur ;
2. un troisième clic pour la hauteur ;
3. adaptation des paramètres du type ;
4. lancement du placement.

### Utilité

Cette commande aide à reproduire rapidement des dimensions relevées sur l'existant ou sur un nuage de points interprété à l'écran.

---

## Créer Type Fenêtre

### But

Appliquer le même principe que la porte, mais pour les familles de fenêtres.

### Particularité technique

La logique métier des commandes porte et fenêtre est mutualisée dans un utilitaire commun (`OpeningTypeCreationUtils`), ce qui réduit les duplications dans le code.

---

## Intérêt global de ces commandes

- accélérer la création de variantes de types ;
- limiter les erreurs de saisie ;
- aligner les dimensions des types sur des mesures prises directement dans le modèle.
