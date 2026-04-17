---
layout: default
title: Architecture
nav_order: 3
---

# Architecture du plugin

## Point d'entrée

Le point d'entrée principal est la classe `App`, qui implémente l'interface `IExternalApplication` de Revit.

Son rôle est de :

- créer l'onglet **ndc26** au démarrage ;
- créer ou récupérer les panneaux du ruban ;
- déclarer chaque bouton lié à une commande ;
- rattacher les descriptions et tooltips visibles dans Revit.

## Organisation des commandes

Chaque commande métier est portée par une classe distincte qui implémente `IExternalCommand`.

Cette approche permet :

- un bouton par fonctionnalité ;
- une logique isolée par commande ;
- une maintenance plus simple des outils ;
- une documentation facilement découpable page par page.

## Composants techniques importants

### Fenêtres d'options

Plusieurs commandes ouvrent des fenêtres Windows Forms pour récupérer des paramètres utilisateur :

- décalage de vue longitudinale ;
- hauteur ou densité de traitement ;
- distance minimale entre étiquettes ;
- réglages de plage de vue ;
- réglages de section box.

### Handlers d'événements Revit

Certaines fonctions temps réel utilisent `IExternalEventHandler` pour appliquer des modifications au document Revit en respectant le modèle d'exécution de l'API :

- `SectionBoxUpdateHandler`
- `PlanViewRangeUpdateHandler`

### Utilitaires partagés

Le projet contient aussi des composants transverses :

- `MeasurementPointPicker` pour sélectionner des points dans Revit ;
- `OpeningTypeCreationUtils` pour mutualiser la logique porte/fenêtre ;
- `CommandUsageTracker` pour les statistiques d'utilisation ;
- `ProjectTimeTracker` pour le temps cumulé par projet.

## Découpage recommandé pour la maintenance

Pour faire évoluer le plugin, il est utile de distinguer :

- les commandes exposées à l'utilisateur ;
- les fenêtres d'options ;
- les handlers techniques ;
- les utilitaires de mesure, de suivi et de persistance.
