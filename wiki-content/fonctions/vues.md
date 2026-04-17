# Fonctions du panneau Vues

Le panneau **Vues** regroupe les commandes les plus directement liées à la lecture, la production et l'ajustement des vues Revit.

## Créer Vue Longitudinale

### But

Créer automatiquement des vues de section longitudinales le long des grilles du projet.

### Utilité

Cette commande évite de recréer manuellement les coupes nécessaires à l'analyse ou à la production documentaire lorsqu'un projet est organisé par axes ou trames.

### Fonctionnement général

1. ouverture d'une fenêtre d'options ;
2. lecture du décalage de délimitation éloignée ;
3. analyse des grilles et des niveaux ;
4. création des vues de coupe ;
5. marquage des vues créées pour les identifier ultérieurement.

### Paramètres connus

- **Décalage de la délimitation éloignée** : distance en mètres appliquée à la profondeur de la vue ;
- **Cacher pour une échelle plus petite que** : champ présent mais non appliqué actuellement.

### Cas d'usage

- générer rapidement les vues le long d'une série de grilles ;
- reconstruire un jeu de vues après modification du quadrillage ;
- standardiser la production d'élévations longitudinales.

## Coter Quadrillage

### But

Créer automatiquement les cotes entre axes de grilles visibles ou sélectionnées dans la vue active.

### Utilité

La commande réduit fortement le temps de cotation des trames et homogénéise la présentation.

### Fonctionnement général

1. récupération de la sélection utilisateur si elle existe ;
2. sinon, analyse des grilles visibles dans la vue active ;
3. détection de la plus grande série de grilles parallèles ;
4. création d'une cote chaînée ;
5. création d'une cote globale entre la première et la dernière grille.

### Résultat attendu

L'utilisateur obtient deux niveaux de lecture :

- les intervalles intermédiaires ;
- la dimension totale de la trame.

## Zone de Coupe

### But

Créer ou mettre à jour une vue 3D avec section box pilotable depuis une fenêtre dédiée.

### Utilité

Cette fonction aide à isoler une zone de travail dans le modèle, notamment pour l'analyse de nuages de points ou de volumes complexes.

### Fonctionnement général

- calcule les limites XY du contexte ;
- propose plusieurs orientations ;
- applique les modifications en temps réel via un handler externe ;
- conserve une fenêtre persistante pour ajuster le cadrage sans relancer la commande.

### Réglages proposés

- orientation Top ;
- orientation Side ;
- vue 3D ;
- sliders d'élévation et d'épaisseur.

## Plage de Vue

### But

Ajuster dynamiquement la plage de vue de la vue de plan active.

### Utilité

La commande simplifie un réglage souvent fastidieux dans les propriétés natives de Revit.

### Fonctionnement général

1. validation que la vue active est un plan ;
2. ouverture d'une fenêtre avec quatre sliders ;
3. envoi des valeurs au `PlanViewRangeUpdateHandler` ;
4. mise à jour des offsets Top, Cut, Bottom et ViewDepth.

### Bénéfice principal

Le réglage est plus visuel et plus rapide que dans la boîte de dialogue standard de Revit.