---
layout: default
title: Installation
nav_order: 4
---

# Installation du plugin RevitAddin

## Prérequis

- Autodesk Revit 2026 installé ;
- accès aux DLL de l'API Revit ;
- environnement Windows ;
- droits suffisants pour copier des fichiers dans le profil utilisateur ou installer un setup.

## Compilation du projet

Le projet cible **.NET Framework 4.8** et référence par défaut les DLL Revit dans :

`C:\Program Files\Autodesk\Revit 2026`

Le binaire produit est une bibliothèque :

- `RevitAddin.dll`

## Méthode 1 — Installation manuelle

1. Ouvrir le projet dans Visual Studio ou compiler avec `dotnet build`.
2. Récupérer la DLL générée dans le dossier de sortie `bin\Debug\net48` ou `bin\Release\net48`.
3. Copier `RevitAddin.dll` vers un emplacement stable.
4. Copier le fichier `RevitAddin.addin` dans `%APPDATA%\Autodesk\Revit\Addins\2026\`.
5. Vérifier que le chemin `<Assembly>` du manifeste pointe vers la bonne DLL.
6. Redémarrer Revit.

## Méthode 2 — Installation via exécutable packagé

1. Compiler la solution en Debug ou Release.
2. Récupérer `RevitAddinInstaller-packaged.exe`.
3. Exécuter l'installateur.
4. L'outil copie automatiquement la DLL et génère le fichier `.addin` avec le bon chemin.

## Méthode 3 — Setup Windows avec Inno Setup

1. Installer Inno Setup 6.
2. Compiler l'add-in en Release.
3. Exécuter le script PowerShell `tools\build-inno-setup.ps1`.
4. Récupérer le setup dans `installer\output\RevitAddinSetup.exe`.

Cette méthode est la plus adaptée pour un déploiement utilisateur car elle gère :

- l'installation dans `Program Files` ;
- la génération du manifeste `.addin` ;
- le raccourci de documentation ;
- la désinstallation Windows.

## Vérification après installation

Après redémarrage de Revit :

1. vérifier la présence de l'onglet **ndc26** ;
2. contrôler que les panneaux et boutons sont visibles ;
3. lancer une commande simple comme **Date Cartouche** ou **Afficher/Masquer Nuage**.

## Problèmes fréquents

### L'onglet n'apparaît pas

- le fichier `.addin` n'est pas au bon emplacement ;
- le chemin vers la DLL est incorrect ;
- la DLL a été compilée avec une mauvaise configuration ;
- la version de Revit ne correspond pas au manifeste.

### La compilation échoue

- le chemin vers `RevitAPI.dll` ou `RevitAPIUI.dll` est absent ou incorrect ;
- Revit 2026 n'est pas installé au chemin attendu ;
- le framework .NET ciblé n'est pas disponible sur le poste.
