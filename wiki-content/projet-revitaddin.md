# Vue d'ensemble du projet RevitAddin

## Objectif

Le projet RevitAddin a été conçu pour intégrer directement dans Revit des outils auparavant portés par un script Dynamo, puis pour enrichir ce socle avec des fonctions utiles à la production.

L'objectif principal est de gagner du temps sur des tâches répétitives ou sensibles aux erreurs manuelles.

## Cible technique

- Application hôte : **Autodesk Revit 2026**
- Langage : **C#**
- Framework : **.NET Framework 4.8**
- Interface : **Windows Forms**
- API utilisée : **RevitAPI** et **RevitAPIUI**

## Périmètre fonctionnel

Le plugin couvre plusieurs besoins :

- création de vues le long des axes de grille ;
- cotation automatique des quadrillages ;
- réglage de section box et de plage de vue ;
- exploitation de nuages de points ;
- création rapide de types de murs, portes et fenêtres à partir de mesures ;
- étiquetage automatique d'éléments structurels ;
- mise à jour de cartouches ;
- suivi du temps et des statistiques d'usage.

## Valeur métier

Les bénéfices attendus sont les suivants :

- réduction des opérations manuelles répétitives ;
- homogénéisation des pratiques de production ;
- accélération de la préparation des vues et des documents ;
- amélioration de la traçabilité via les statistiques d'usage et le temps passé.

## Organisation visible dans Revit

Au démarrage, l'add-in crée un onglet **ndc26**. Les commandes sont regroupées par domaine métier afin de faciliter leur repérage par les utilisateurs.

Cette organisation est importante pour la documentation car elle constitue aussi la meilleure structure de navigation dans Wiki.js.

## Limites connues

- le champ d'option lié à l'échelle minimale dans la création de vue longitudinale n'est pas encore exploité ;
- le manifeste `.addin` peut contenir un chemin absolu qui doit être adapté selon l'environnement ;
- le projet ne contient pas de tests automatisés ;
- certaines erreurs internes sont capturées sans journalisation détaillée.