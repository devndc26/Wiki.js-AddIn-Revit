---
layout: default
title: Vues
parent: Fonctions
nav_order: 1
---

# Fonctions du panneau Vues

Le panneau **Vues** regroupe les commandes les plus directement liées à la lecture, la production et l'ajustement des vues Revit.

## Créer Vue Longitudinale

### But

Créer automatiquement des vues de section longitudinales le long des grilles du projet.

### Utilité

Cette commande évite de recréer manuellement les coupes nécessaires à l'analyse ou à la production documentaire lorsqu'un projet est organisé par axes ou trames.

### Fonctionnement général

1. **Fenêtre d'options** : Ouverture d'une interface pour saisir les paramètres de décalage ;
2. **Analyse géométrique** : Lecture du décalage de délimitation éloignée (en mètres) ;
3. **Détection des axes** : Analyse automatique des grilles et des niveaux du projet ;
4. **Création des vues** : Génération des vues de coupe pour chaque grille (une par niveau) ;
5. **Marquage** : Ajout d'un marqueur Extensible Storage pour identifier les vues créées.

### Paramètres

- **Décalage de la délimitation éloignée** : distance en mètres ajoutée à la profondeur de la vue de coupe ;
- **Nom par défaut** : les vues sont nommées "Coupe Grille" (avec suffixe automatique si doublon).

### Implémentation technique

- Classe : `Command.cs` → `IExternalCommand`
- Utilise `FilteredElementCollector` pour analyser les grilles et niveaux
- Schéma Extensible Storage : GUID `A0E6512A-1904-47A1-BF7F-3073E9B44E6D` pour marquer les vues créées
- Conversion d'unités : mètres (interface utilisateur) ↔ unités internes Revit

### Cas d'usage

- générer rapidement les vues le long d'une série de grilles ;
- reconstruire un jeu de vues après modification du quadrillage ;
- standardiser la production d'élévations longitudinales.

---

## Coter Quadrillage

### But

Créer automatiquement les cotes entre axes de grilles visibles ou sélectionnées dans la vue active.

### Utilité

La commande réduit fortement le temps de cotation des trames et homogénéise la présentation en créant une chaîne de cotes intermédiaires plus une cote globale.

### Fonctionnement général

1. **Détection de vue** : Valide que la vue active est un plan ou une coupe ;
2. **Récupération des grilles** : Analyse soit la sélection utilisateur, soit les grilles visibles ;
3. **Groupement parallèle** : Détecte les séries de grilles parallèles (tolérance : 1e-4) ;
4. **Hiérarchisation** : Sélectionne la plus grande série de grilles ;
5. **Création des cotes** : Ajoute une chaîne de cotes intermédiaires + une cote globale.

### Résultat attendu

L'utilisateur obtient deux niveaux de lecture :

- les intervalles intermédiaires (cote chaînée) ;
- la dimension totale de la trame (cote globale).

### Implémentation technique

- Classe : `DimensionGridsCommand.cs` → `IExternalCommand`
- Fonctionne en plan et en coupe/élévation
- Détecte les groupes parallèles avec analyse géométrique
- Cote dimensionnelle avec texte automatique

---

## Zone de Coupe

### But

Créer ou mettre à jour une vue 3D avec section box dynamiquement contrôlable depuis une fenêtre dédiée.

### Utilité

Cette fonction aide à isoler une zone de travail dans le modèle, notamment pour l'analyse de nuages de points ou de volumes complexes.

### Fonctionnement général

- **Initialisation** : Calcule les limites XY du contexte du projet ;
- **Interface graphique** : Propose plusieurs orientations (Top, Side, 3D) avec sliders ;
- **Mise à jour temps réel** : Applique les modifications via `SectionBoxUpdateHandler` ;
- **Persistance** : Conserve une fenêtre persistante pour ajuster le cadrage sans relancer la commande.

### Paramètres contrôlables

- **Orientation** : Top, Side, vue 3D personnalisée
- **Élévation (Z)** : Slider pour déplacer le plan de base
- **Épaisseur** : Slider pour modifier la profondeur (ViewDepth)
- **Limites XY** : Automatiquement calculées d'après les grilles/niveaux

### Implémentation technique

- Classe : `CreateCubeBoxCommand.cs` + `SectionBoxUpdateHandler.cs`
- `SectionBoxUpdateHandler` : implémente `IExternalEventHandler` pour les modifications temps réel
- Interface : `CubeBoxOptionsWindow.cs` (Windows Forms)
- Gestion transactions : Contrôles internes via Event Handler

---

## Plage de Vue

### But

Ajuster dynamiquement la plage de vue (View Range) d'une vue de plan active.

### Utilité

La commande simplifie un réglage souvent fastidieux dans les propriétés natives de Revit en exposant une interface dédiée.

### Fonctionnement général

1. **Validation** : Vérifie que la vue active est un plan 2D ;
2. **Interface** : Ouvre une fenêtre avec quatre sliders indépendants ;
3. **Transmission** : Envoie les valeurs au `PlanViewRangeUpdateHandler` ;
4. **Mise à jour** : Modifie en temps réel les offsets Top, Cut, Bottom et ViewDepth.

### Paramètres contrôlables

- **Top** : Hauteur du plan de coupe supérieur
- **Cut** : Altitude du plan de découpe principal
- **Bottom** : Hauteur du plan de coupe inférieur
- **View Depth** : Profondeur additionnelle au-delà du plan de base

### Implémentation technique

- Classe : `ActiveViewRangeCommand.cs` + `PlanViewRangeUpdateHandler.cs`
- `PlanViewRangeUpdateHandler` : implémente `IExternalEventHandler`
- Interface : `PlanViewRangeOptionsWindow.cs` (Windows Forms)
- Restriction : Valide que la vue est bien un plan avant application
