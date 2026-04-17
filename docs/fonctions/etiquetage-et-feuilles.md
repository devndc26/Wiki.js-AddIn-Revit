---
layout: default
title: Etiquetage et Feuille
parent: Fonctions
nav_order: 4
---

# Fonctions des panneaux Etiquetage et Feuille

## Etiqueter Structure

### But

Ajouter automatiquement des étiquettes aux éléments structurels visibles dans la vue active.

### Eléments concernés

- poteaux porteurs (Structural Columns) ;
- éléments d'ossature structurelle (Structural Framing).

### Utilité

La commande facilite l'annotation d'une vue sans devoir étiqueter chaque élément manuellement, tout en respectant une distance minimale pour éviter les superpositions.

### Fonctionnement général

1. **Fenêtre de paramétrage** : Saisie de la distance minimale entre étiquettes ;
2. **Collecte des éléments** : Récupération de tous les poteaux et ossature visibles dans la vue ;
3. **Création des tags** : Génération des étiquettes avec le type de tag par défaut du projet ;
4. **Contrôle de proximité** : Analyse des distances entre tags adjacents ;
5. **Suppression des doublons** : Suppression des étiquettes trop proches pour éviter les chevauchements.

### Paramètre utilisateur

- **distance minimale entre étiquettes** : en unités Revit (par défaut 1-2 mètres), représente l'espace minimum requis entre deux tags

### Implémentation technique

- Classe : `TagStructuralElementsCommand.cs` → `IExternalCommand`
- Fenêtre d'options : `TagOptionsWindow.cs` (Windows Forms)
- Catégories ciblées : `BuiltInCategory.OST_StructuralColumns`, `BuiltInCategory.OST_StructuralFraming`
- API : `View.AddTag(Element)` pour création de tags
- Algo de proximité : Géométrie bounding box comparée à la distance mini paramétrée

---

## Date Cartouche

### But

Mettre à jour automatiquement la date des cartouches du projet avec la date du jour.

### Utilité

Cette commande évite les oublis de mise à jour de date avant émission, révision ou archivage. Elle exécute en une seule opération ce qui prendrait sinon plusieurs clics par feuille.

### Logique appliquée

La commande cherche d'abord des paramètres nommés comme :

- `Date` (exact)
- `DATE` (exact)
- `Date de fin` (exact)
- `Date du plan` (exact)
- `Plan date` (exact)

Si aucun de ces paramètres n'existe, elle tente de trouver un paramètre texte **contenant le mot** `date` (recherche partiellement chaîne).

### Résultat attendu

Tous les cartouches concernés (Title Blocks) reçoivent la date du jour au format `dd/MM/yyyy`.

### Implémentation technique

- Classe : `UpdateTitleBlockDateCommand.cs` → `IExternalCommand`
- Collecte : `FilteredElementCollector` sur les cartouches (catégorie Title Blocks)
- Détection de paramètre : Liste des noms attendus + recherche par substring
- Mise à jour : Paramètre texte remplacé par nouvelle date
- Format : `DateTime.Now.ToString("dd/MM/yyyy")` (locale système respectée)
- Transaction : Toutes les modifications en une seule transaction
