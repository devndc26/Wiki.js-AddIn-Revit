---
layout: default
title: À propos
parent: Fonctions
nav_order: 6
---

# À propos du plugin

## Commande À propos

### But

Afficher les informations de version, vérifier la disponibilité des mises à jour et accéder à la documentation du plugin.

### Utilité

La commande centralise l'accès aux informations système et aux ressources utiles du plugin en un seul endroit.

### Fonctionnement

La fenêtre affiche :

- **Version installée** : Numéro de version du plugin actuellement chargé
- **Vérification des mises à jour** : Requête vers GitHub pour récupérer la dernière release disponible
- **Liens utiles** :
  - Accès à la documentation locale (ce wiki)
  - Lien vers le repository GitHub du projet
  - Informations de contact

### Implémentation technique

- Classe : `AboutCommand.cs` → `IExternalCommand`
- Fenêtre d'affichage : `AboutWindow.cs` (Windows Forms)
- Vérification mises à jour : `GitHubPrivateUpdateService.cs` (requête REST API GitHub)
- Version : Récupérée depuis l'assembly metadata (AssemblyVersion)
- Documentation locale : Intégration possible avec raccourci vers README.md

## Architecture des utilitaires

### CommandUsageTracker

Utilitaire centralisé pour l'enregistrement des utilisations de commandes.

- **Fichier** : `CommandUsageTracker.cs`
- **Fonction** : `RecordCommandUsage(Document doc, string commandName)`
- **Stockage** : Extensible Storage du document Revit
- **Utilisation** : Appelé systématiquement au démarrage de chaque commande

### ProjectTimeTracker

Utilitaire pour la persévération du temps passé par projet.

- **Fichier** : `ProjectTimeTracker.cs`
- **Données** : Date/heure de dernière session, cumul en secondes
- **Stockage** : Extensible Storage du document Revit
- **Précision** : Secondes

### MeasurementPointPicker

Utilitaire interactif pour la sélection de points dans la vue.

- **Fichier** : `MeasurementPointPicker.cs`
- **Utilisation** : Créer Type Mur, Créer Type Porte, Créer Type Fenêtre
- **Mode** : Sélection graphique de points 3D dans la fenêtre Revit
- **Résultat** : Coordonnées XYZ des points sélectionnés

### OpeningTypeCreationUtils

Utilitaire mutualisé pour la création de types de portes et fenêtres.

- **Fichier** : `OpeningTypeCreationUtils.cs`
- **Fonctionnalités** :
  - Création ou récupération de type existant
  - Mise à jour des paramètres de dimension
  - Gestion du placement immédiat après création
- **Utilisateurs** : `CreateDoorTypeFromMeasuredDimensionsCommand`, `CreateWindowTypeFromMeasuredDimensionsCommand`

## Événements externes (IExternalEventHandler)

### SectionBoxUpdateHandler

Gestionnaire d'événements pour les modifications temps réel de Section Box.

- **Fichier** : `SectionBoxUpdateHandler.cs`
- **Utilisation** : Zone de Coupe (commande `CreateCubeBoxCommand`)
- **Rôle** : Appliquer les modifications d'offset et de profondeur de façon synchrone avec l'API Revit

### PlanViewRangeUpdateHandler

Gestionnaire d'événements pour les modifications temps réel de plage de vue.

- **Fichier** : `PlanViewRangeUpdateHandler.cs`
- **Utilisation** : Plage de Vue (commande `ActiveViewRangeCommand`)
- **Rôle** : Mettre à jour les paramètres Top, Cut, Bottom, ViewDepth de manière synchrone

## Fenêtres d'options (Windows Forms)

Le plugin utilise plusieurs fenêtres Windows Forms pour la saisie de paramètres :

| Fenêtre | Fichier | Utilisée par | Paramètres |
| --- | --- | --- | --- |
| OptionsWindow | `OptionsWindow.cs` | Créer Vue Longitudinale | Décalage délimitation éloignée |
| CubeBoxOptionsWindow | `CubeBoxOptionsWindow.cs` | Zone de Coupe | Orientation, élévation, épaisseur |
| PlanViewRangeOptionsWindow | `PlanViewRangeOptionsWindow.cs` | Plage de Vue | Top, Cut, Bottom, ViewDepth |
| FloorFromPointCloudOptionsWindow | `FloorFromPointCloudOptionsWindow.cs` | Plancher Nuage | Densité, taille grille, hauteur recherche |
| TagOptionsWindow | `TagOptionsWindow.cs` | Étiqueter Structure | Distance minimale entre tags |
| ProjectTimeWindow | `ProjectTimeWindow.cs` | Temps Projet | (affichage, pas de paramètres) |
| CommandUsageStatsWindow | `CommandUsageStatsWindow.cs` | Stats Usage | (affichage trié, pas de paramètres) |
| ProcessingProgressWindow | `ProcessingProgressWindow.cs` | Plancher Nuage | (barre de progression, pas de paramètres utilisateur) |

## Configuration et déploiement

### Manifeste .addin

Fichier : `RevitAddin.addin`

Décrit le point d'entrée externe et les métadonnées du plugin pour que Revit le charge au démarrage.

**Éléments clés** :

- Chemin vers l'assembly DLL (à adapter selon l'installation)
- Class FQDN : `RevitAddin.App` (implémente `IExternalApplication`)
- Métadonnées : Nom, description, version

### Project File

Fichier : `RevitAddin.csproj`

- Cible Framework : **.NET Framework 4.8**
- Références API Revit : DLL du SDK Revit 2026
- Configuration de build : Debug/Release

## Commandes non-documentées

### AboutCommand

Affiche la fenêtre "À propos" du plugin (voir section dédiée ci-dessus).

---

**Révision** : Documentation générée à partir du code source C# du plugin RevitAddin.
