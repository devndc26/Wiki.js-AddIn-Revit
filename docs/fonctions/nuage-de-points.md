---
layout: default
title: Nuage de points
parent: Fonctions
nav_order: 2
---

# Fonctions du panneau Nuage de point

Le panneau **Nuage de point** regroupe les outils permettant d'exploiter et de visualiser les données de relevé dans Revit.

## Afficher/Masquer Nuage

### But

Basculer la visibilité de la catégorie **Nuage de point** dans la vue active.

### Utilité

Cette commande permet de nettoyer rapidement l'affichage pour se concentrer sur le modèle BIM ou, au contraire, de réafficher le relevé pour contrôler une situation existante.

### Fonctionnement

- la commande cible la catégorie `OST_PointClouds` (Revit Category) ;
- elle inverse l'état visible/masqué (toggle) dans la vue active ;
- son usage est immédiat et ne demande pas de paramétrage.

### Implémentation technique

- Classe : `TogglePointCloudCommand.cs` → `IExternalCommand`
- API utilisée : `View.SetCategoryHidden(Category, bool)` de Revit
- Catégorie cible : `BuiltInCategory.OST_PointClouds`
- Enregistrement : Utilisation de `CommandUsageTracker` pour statistiques

---

## Plancher Nuage

### But

Ajuster la géométrie d'un plancher à partir d'un nuage de points en appliquant des points de forme.

### Utilité

Cette fonction est particulièrement utile pour modéliser un plancher existant irrégulier à partir d'un relevé nuisé ou un levé photogrammétrique.

### Séquence d'utilisation

1. **Sélection du plancher** : Cliquer sur l'élément Floor à modifier ;
2. **Sélection du nuage** : Choisir le Point Cloud à utiliser comme référence ;
3. **Paramétrage** : Configurer la densité (haute/moyenne/faible), la taille de grille et la hauteur de recherche ;
4. **Validation** : Lancer le traitement avec barre de progression ;
5. **Résultat** : Application automatique des points de forme au plancher.

### Paramètres disponibles

- **Densité** : haute (plus de points), moyenne (équilibre), faible (moins de points, plus rapide) ;
- **Taille de grille** : pas de découpage spatial en mètres (contrôle la résolution d'échantillonnage) ;
- **Hauteur de recherche** : plage verticale en mètres utilisée pour l'échantillonnage (ex. ±0.5m).

### Interface associée

- Fenêtre d'options : `FloorFromPointCloudOptionsWindow.cs` (Windows Forms)
- Barre de progression : `ProcessingProgressWindow.cs` (avec temps restant estimé)
- Bouton d'annulation pour arrêter le traitement

### Implémentation technique

- Classe : `CreateFloorFromPointCloudCommand.cs` → `IExternalCommand`
- Algorithme : Échantillonnage spatial de la nuée de points selon la grille paramétrée
- Conversion : Application des Z échantillonnés aux points de forme du plancher
- Transactions : Enregistrement des modifications du plancher en une seule transaction

### Intérêt métier

Elle permet de transformer un relevé brut en support de modélisation exploitable sans reprendre toute la géométrie à la main, tout en gardant la traçabilité du relevé source.
