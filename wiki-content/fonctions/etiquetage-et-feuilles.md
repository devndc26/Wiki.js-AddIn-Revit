# Fonctions des panneaux Etiquetage et Feuille

## Etiqueter Structure

### But

Ajouter des étiquettes aux éléments structurels visibles dans la vue active.

### Eléments concernés

- poteaux porteurs ;
- éléments d'ossature structurelle.

### Utilité

La commande facilite l'annotation d'une vue sans devoir étiqueter chaque élément manuellement.

### Fonctionnement général

1. collecte des éléments visibles des catégories ciblées ;
2. création des tags ;
3. contrôle des proximités ;
4. suppression des étiquettes trop proches pour éviter les chevauchements.

### Paramètre utilisateur

- distance minimale entre étiquettes.

## Date Cartouche

### But

Mettre à jour automatiquement la date des cartouches du projet avec la date du jour.

### Utilité

Cette commande évite les oublis de mise à jour de date avant émission ou révision.

### Logique appliquée

La commande cherche d'abord des paramètres nommés comme :

- `Date`
- `DATE`
- `Date de fin`
- `Date du plan`
- `Plan date`

Si aucun de ces paramètres n'existe, elle tente de trouver un paramètre texte contenant le mot `date`.

### Résultat attendu

Tous les cartouches concernés reçoivent la date du jour au format `dd/MM/yyyy`.