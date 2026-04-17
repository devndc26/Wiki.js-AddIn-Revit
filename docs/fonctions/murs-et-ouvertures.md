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

Créer ou réutiliser un type de mur selon une épaisseur mesurée entre deux points sélectionnés.

### Utilité

Cette commande sert à produire rapidement un type cohérent avec l'existant ou avec une mesure relevée, sans ressaisir manuellement toute la structure du type.

### Fonctionnement

1. **Sélection des points** : Cliquer sur deux points dans la vue Revit ;
2. **Mesure** : Calcul de la distance XY (projetée horizontalement) ;
3. **Recherche de type** : Vérification si un type de mur avec l'épaisseur correspondante existe ;
4. **Création/Réutilisation** : Création du type ou utilisation d'un type existant ;
5. **Mise à jour** : Ajustement de l'épaisseur de la première couche de coeur (structure).

### Implémentation technique

- Classe : `CreateWallTypeFromMeasuredDistanceCommand.cs` → `IExternalCommand`
- Mesure : `MeasurementPointPicker.cs` pour la sélection interactive de deux points
- Distance : Calcul XY (ignore la composante Z)
- Type naming : Basé sur l'épaisseur arrondie (ex. "Mur 200")
- Utilité commune : `OpeningTypeCreationUtils.cs` pour la logique type/création

---

## Créer Type Porte

### But

Créer ou réutiliser un type de porte à partir d'une largeur et d'une hauteur mesurées en trois clics.

### Fonctionnement

1. **Premier clic** : Désigner le premier point pour la largeur ;
2. **Deuxième clic** : Désigner le second point (largeur calculée = distance XY) ;
3. **Troisième clic** : Désigner un point en hauteur (hauteur = distance Z) ;
4. **Création/Réutilisation** : Création du type ou utilisation d'un type existant ;
5. **Lancement** : Le placement de la porte s'effectue automatiquement.

### Utilité

Cette commande aide à reproduire rapidement des dimensions relevées sur l'existant ou sur un nuage de points interprété à l'écran, sans ressaisir les valeurs.

### Implémentation technique

- Classe : `CreateDoorTypeFromMeasuredDimensionsCommand.cs` → `IExternalCommand`
- Mesure : `MeasurementPointPicker.cs` pour trois points interactifs
- Largeur : Distance XY entre les deux premiers points
- Hauteur : Distance Z du troisième point
- Utilitaire commun : `OpeningTypeCreationUtils.cs` partagé avec les fenêtres
- Type naming : Basé sur dimension en format "L×H" (ex. "800×2100")

---

## Créer Type Fenêtre

### But

Appliquer le même principe que la porte, mais pour les familles de fenêtres.

### Particularité technique

La logique métier des commandes porte et fenêtre est mutualisée dans un utilitaire commun (`OpeningTypeCreationUtils.cs`), ce qui réduit les duplications dans le code et facilite la maintenance.

### Implémentation

- Classe : `CreateWindowTypeFromMeasuredDimensionsCommand.cs` → `IExternalCommand`
- Logique partagée : `OpeningTypeCreationUtils.cs` (création type, positionnement, gestion erreurs)
- Mesure : Identique à la porte (2 points largeur + 1 point hauteur)

---

## Intérêt global de ces commandes

- accélérer la création de variantes de types ;
- limiter les erreurs de saisie ;
- aligner les dimensions des types sur des mesures prises directement dans le modèle.
