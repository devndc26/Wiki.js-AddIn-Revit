---
layout: home
title: Accueil
nav_order: 1
---

# RevitAddin — Documentation

Bienvenue sur l'espace de documentation du projet **RevitAddin**.

Ce wiki a pour objectif d'expliquer de façon claire et détaillée :

- le but du projet ;
- les fonctions disponibles dans Revit ;
- l'organisation interne du code ;
- la procédure d'installation et de déploiement ;
- les points d'attention pour la maintenance.

## Résumé du projet

RevitAddin est un add-in natif pour **Revit 2026** écrit en **C# / .NET Framework 4.8**. Il transforme un besoin initial autour de la création de vues longitudinales sur quadrillage en un ensemble d'outils de production plus large.

Le plugin ajoute un onglet **ndc26** dans le ruban Revit avec plusieurs panneaux spécialisés.

## Fonctions disponibles

| Panneau | Fonctions |
| --- | --- |
| Vues | Créer Vue Longitudinale, Coter Quadrillage, Zone de Coupe, Plage de Vue |
| Nuage de point | Afficher/Masquer Nuage, Plancher Nuage |
| Murs | Créer Type Mur |
| Ouvertures | Créer Type Porte, Créer Type Fenêtre |
| Etiquetage | Etiqueter Structure |
| Feuille | Date Cartouche |
| Outils | Temps Projet, Stats Usage |

## Parcours conseillé

1. Lire la page **[Vue d'ensemble](projet-revitaddin/)** pour comprendre le périmètre du projet.
2. Consulter **[Architecture](architecture/)** pour voir comment l'add-in est structuré.
3. Parcourir les pages **[Fonctions](fonctions/)** selon le panneau Revit concerné.
4. Terminer par **[Installation](installation-addon/)** pour la mise en place sur un poste utilisateur.

## Public visé

- les utilisateurs métier qui veulent comprendre les outils disponibles ;
- les développeurs qui doivent maintenir ou faire évoluer le plugin ;
- les personnes chargées de l'installation sur les postes Revit.
