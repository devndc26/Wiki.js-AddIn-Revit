# Wiki.js pour documenter RevitAddin

Ce workspace contient une base locale Wiki.js et un jeu de pages Markdown prêtes à intégrer pour documenter le projet RevitAddin situé dans `C:\Users\Pc9\Documents\Revit\Créer Vue Longitudinale sur Grid\RevitAddin`.

## Contenu du workspace

- `docker-compose.yml` : stack locale Wiki.js + PostgreSQL.
- `.env.example` : variables d'environnement à copier dans `.env`.
- `wiki-content/` : contenu rédigé en Markdown pour vos pages Wiki.js.

## Lancer Wiki.js localement

### Prérequis

- Docker Desktop installé et démarré.
- Le port `3000` disponible sur la machine.

### Démarrage

1. Copiez `.env.example` vers `.env`.
2. Ajustez au besoin le mot de passe PostgreSQL et le port.
3. Depuis ce dossier, lancez `docker compose up -d`.
4. Ouvrez `http://localhost:3000`.
5. Terminez l'assistant initial de Wiki.js.

## Importer le contenu dans Wiki.js

Le dossier `wiki-content/` contient le texte des pages. La manière la plus simple est de créer les pages manuellement dans Wiki.js puis de coller le contenu correspondant.

### Import automatique

Un script PowerShell est disponible pour créer les pages automatiquement dans Wiki.js a partir des fichiers Markdown.

- Script: `scripts/import-wikijs.ps1`
- Mapping des pages: `wiki-import-map.json`

#### Prerequis

1. Creer un jeton API dans l'administration Wiki.js (droits pages).
2. Definir la variable d'environnement PowerShell:

```powershell
$env:WIKIJS_API_TOKEN = "VOTRE_JETON_API"
```

#### Test sans ecriture

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\import-wikijs.ps1 -DryRun
```

#### Import reel

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\import-wikijs.ps1 -Publish -UpdateExisting
```

#### Parametres utiles

- `-BaseUrl` (defaut: `http://localhost:3000`)
- `-Locale` (defaut: `fr`)
- `-ConfigFile` (defaut: `wiki-import-map.json`)
- `-Publish` pour publier les pages
- `-UpdateExisting` pour mettre a jour les pages deja existantes
- `-DryRun` pour valider le mapping sans appel API

### Arborescence recommandée

- `/` : `wiki-content/accueil.md`
- `/revitaddin/vue-d-ensemble` : `wiki-content/projet-revitaddin.md`
- `/revitaddin/architecture` : `wiki-content/architecture.md`
- `/revitaddin/installation-addon` : `wiki-content/installation-addon.md`
- `/revitaddin/fonctions/vues` : `wiki-content/fonctions/vues.md`
- `/revitaddin/fonctions/nuage-de-points` : `wiki-content/fonctions/nuage-de-points.md`
- `/revitaddin/fonctions/murs-et-ouvertures` : `wiki-content/fonctions/murs-et-ouvertures.md`
- `/revitaddin/fonctions/etiquetage-et-feuilles` : `wiki-content/fonctions/etiquetage-et-feuilles.md`
- `/revitaddin/fonctions/outils-de-suivi` : `wiki-content/fonctions/outils-de-suivi.md`
- `/revitaddin/plan-de-publication` : `wiki-content/plan-de-publication.md`

## Ce que couvre la documentation

- Le rôle global du plugin Revit.
- Les panneaux et commandes disponibles dans l'onglet `ndc26`.
- Le rôle des fenêtres d'options et handlers techniques.
- Les méthodes d'installation du plugin dans Revit 2026.
- Une proposition de structure de publication dans Wiki.js.

## Limites connues

- L'import automatique depend d'un jeton API Wiki.js valide et des droits associes.
- Le contenu est basé sur l'état actuel du code source. Si le plugin évolue, il faudra mettre à jour les pages concernées.