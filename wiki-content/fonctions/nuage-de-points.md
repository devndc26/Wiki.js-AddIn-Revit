# Fonctions du panneau Nuage de point

Le panneau **Nuage de point** regroupe les outils permettant d'exploiter et de visualiser les données de relevé dans Revit.

## Afficher/Masquer Nuage

### But

Basculer la visibilité de la catégorie **Nuage de point** dans la vue active.

### Utilité

Cette commande permet de nettoyer rapidement l'affichage pour se concentrer sur le modèle BIM ou, au contraire, de réafficher le relevé pour contrôler une situation existante.

### Fonctionnement

- la commande cible la catégorie `OST_PointClouds` ;
- elle inverse l'état visible/masqué dans la vue active ;
- son usage est immédiat et ne demande pas de paramétrage.

## Plancher Nuage

### But

Ajuster la géométrie d'un plancher à partir d'un nuage de points.

### Utilité

Cette fonction est particulièrement utile pour modéliser un plancher existant irrégulier à partir d'un relevé.

### Séquence d'utilisation

1. sélectionner un plancher ;
2. sélectionner un nuage de points ;
3. choisir une densité de traitement ;
4. définir la taille de grille et la hauteur de recherche ;
5. lancer le traitement.

### Paramètres disponibles

- **Densité** : haute, moyenne ou faible ;
- **Taille de grille** : pas de découpage spatial ;
- **Hauteur** : plage verticale utilisée pour l'échantillonnage.

### Interface associée

La commande s'appuie sur :

- une fenêtre d'options ;
- une barre de progression ;
- une estimation du temps restant ;
- un bouton d'annulation.

### Intérêt métier

Elle permet de transformer un relevé brut en support de modélisation exploitable sans reprendre toute la géométrie à la main.