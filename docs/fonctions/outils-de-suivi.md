---
layout: default
title: Outils de suivi
parent: Fonctions
nav_order: 5
---

# Fonctions du panneau Outils

Le panneau **Outils** apporte des fonctions de suivi plutôt que de production graphique directe.

## Temps Projet

### But

Afficher le temps cumulé passé sur le projet courant, incluant la session actuelle.

### Utilité

Cette fonction est utile pour :

- le suivi interne et la facturation horaire ;
- l'analyse du temps de production par projet ;
- connaître le volume d'activité sur un fichier Revit ;
- optimiser les processus en identifiant les projets chronophages.

### Fonctionnement

- **Persévération par projet** : Un suivi par projet est maintenu (basé sur l'identifiant unique du projet) ;
- **Session active** : Le temps écoulé depuis le dernier lancement du add-in est ajouté au cumul ;
- **Fenêtre d'affichage** : Affiche les jours, heures et minutes de manière lisible ;
- **Rafraîchissement** : Mise à jour périodique de l'affichage pendant que la fenêtre reste ouverte.

### Implémentation technique

- Classe : `ShowProjectTimeCommand.cs` → `IExternalCommand`
- Suivi persistant : `ProjectTimeTracker.cs` (stockage Extensible Storage)
- Fenêtre d'affichage : `ProjectTimeWindow.cs` (Windows Forms)
- Unité de temps : Enregistrement en secondes, conversion en jours/heures/minutes
- Schéma : Extensible Storage pour persévération entre sessions

---

## Stats Usage

### But

Afficher combien de fois les commandes du plugin ont été utilisées pour le projet actif.

### Utilité

Les statistiques d'usage permettent de :

- savoir quelles fonctions sont réellement utilisées ;
- identifier les fonctions à améliorer en priorité (les plus utilisées) ;
- détecter les fonctions peu utilisées (candidates pour dépublication ou refonte) ;
- objectiver les demandes d'évolution basées sur l'usage réel.

### Fonctionnement

- **Enregistrement** : Chaque commande exécutée enregistre son utilisation via `CommandUsageTracker` ;
- **Stockage** : Les compteurs sont persévérés via Extensible Storage ;
- **Récupération** : La fenêtre Stats lit et agrège les compteurs par projet ;
- **Affichage** : Liste triée par utilisation (décroissant), avec le nombre d'appels par fonction.

### Implémentation technique

- Classe : `ShowCommandUsageStatsCommand.cs` → `IExternalCommand`
- Enregistrement : `CommandUsageTracker.RecordCommandUsage(doc, "Nom Commande")` appelé dans chaque commande
- Fenêtre d'affichage : `CommandUsageStatsWindow.cs` (Windows Forms)
- Persistance : Extensible Storage avec schéma par projet
- Tri : Utilitaire de tri décroissant (plus utilisée en premier)

---

## Intérêt de ces outils

Ces fonctions servent surtout à piloter l'amélioration du plugin et à objectiver l'usage réel des outils développés.
