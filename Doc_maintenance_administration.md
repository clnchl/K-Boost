# Documentation de maintenance et d'administration – K-Boost

## Sommaire

1. Note de cadrage
2. Présentation de l'application
3. Fonctionnalités principales
4. Architecture logicielle
5. Technologies et bibliothèques utilisées
6. Environnement technique
7. Installation et mise en service
8. Gestion de la base de données
9. Déploiement de l'application
10. Maintenance et exploitation
11. Assistance et gestion des incidents
12. Modèle de rapport d'incident
13. Conclusion



## 1. Contexte du projet

K-Boost est une application mobile développée dans le cadre d'un projet d'apprentissage. Son objectif est de proposer une plateforme permettant aux utilisateurs de découvrir et d'apprendre la langue coréenne grâce à des contenus pédagogiques structurés.

L'application a été conçue selon une architecture moderne reposant sur une séparation entre le client mobile, l'API backend et la base de données.

## Objectifs du projet

Les objectifs principaux de K-Boost sont :

* Faciliter l'apprentissage du coréen
* Fournir des contenus pédagogiques accessibles depuis un smartphone
* Organiser le vocabulaire par catégories
* Proposer des modules de cours thématiques
* Permettre l'évaluation des connaissances grâce à des quiz interactifs

## Public cible

L'application s'adresse principalement aux débutants souhaitant découvrir la langue coréenne ainsi qu'aux utilisateurs désirant enrichir leur vocabulaire et consolider leurs connaissances.

---

# 2. Présentation de l'application

K-Boost est une application mobile multiplateforme développée avec Flutter.

L'utilisateur peut consulter différents contenus pédagogiques organisés sous forme de catégories, de modules de cours et de quiz.

L'application communique avec une API REST développée avec NestJS qui permet de récupérer les données stockées dans une base PostgreSQL.

## Fonctionnalités principales

La version actuelle permet :

* la consultation de catégories de vocabulaire 
* l'affichage de listes de mots 
* la consultation du détail d'un mot 
* l'accès à des modules d'apprentissage 
* la consultation de contenus théoriques 
* la réalisation de quiz

---

# 3. Architecture logicielle

K-Boost repose sur une architecture client-serveur.

L'application Flutter agit comme client mobile. Les requêtes sont envoyées à une API REST développée avec NestJS. Les données sont ensuite récupérées dans une base PostgreSQL via Prisma ORM.

Architecture générale :

Application Flutter
↓
API REST NestJS
↓
Prisma ORM
↓
Base PostgreSQL

[Insérer ici un schéma d'architecture]

## Description des couches

### Frontend

Le frontend correspond à l'application mobile développée avec Flutter.

Responsabilités :

* affichage de l'interface utilisateur 
* navigation entre les écrans 
* consommation des services REST 
* affichage des cours, mots et quiz

### Backend

Le backend est développé avec NestJS.

Responsabilités :

* exposition des endpoints REST 
* gestion de la logique métier 
* communication avec la base de données 
* sécurisation des accès

### Base de données

La persistance des données est assurée par PostgreSQL.

Les informations stockées concernent notamment :

* les catégories 
* les mots 
* les cours 
* les quiz

---

# 4. Technologies et bibliothèques utilisées

## Frontend

* Flutter
* Dart

## Backend

* NestJS
* TypeScript
* Node.js

## Base de données

* PostgreSQL
* Prisma ORM

## Gestion du code source

* Git
* GitHub

## Hébergement

* Render

## Outils complémentaires

* Prisma Studio
* Postman
* Visual Studio Code
* Cursor

---

# 5. Environnement technique

## Systèmes pris en charge

L'application mobile est compatible avec :

* Android
* iOS

## Éditeurs de code recommandés

Les développements peuvent être réalisés avec :

* Visual Studio Code
* Cursor

## Outils requis

Avant de démarrer le projet, les éléments suivants doivent être installés :

* Flutter SDK
* Node.js
* npm
* PostgreSQL

## Vérification des prérequis

```bash
flutter --version
node --version
npm --version
psql --version
```

## Variables d'environnement

Le backend nécessite un fichier `.env`.

Exemples de variables utilisées :

```env
DATABASE_URL=
PORT=
```

Ces variables permettent notamment de configurer la connexion à la base de données et le port d'exécution du serveur.

---

# 6. Installation et mise en service

## Installation du backend

```bash
cd backend
npm install
```

Copier ensuite le fichier d'exemple :

```bash
cp .env.example .env
```

Configurer les variables d'environnement.

## Installation du frontend

```bash
flutter pub get
```

---

# 7. Gestion de la base de données

## Création de la base

```bash
createdb kboost
```

Si nécessaire :

```bash
psql -U postgres -c "CREATE DATABASE kboost;"
```

## Génération du client Prisma

```bash
npm run db:generate
```

## Application des migrations

```bash
npm run db:migrate
```

## Insertion des données initiales

```bash
npm run db:seed
```

## Consultation de la base

```bash
npm run db:studio
```

Prisma Studio permet de visualiser et modifier les données directement depuis une interface graphique.

---

# 8. Déploiement de l'application

Le backend est hébergé sur Render.

## Configuration du service

Root directory :

```text
backend
```

Build command :

```bash
npm install && npm run build:render
```

Start command :

```bash
npm run start:prod
```

## Base de données Render

La base PostgreSQL est hébergée sur Render.

Deux types d'URL sont disponibles :

* DATABASE_URL interne (utilisée par les services Render)
* External Database URL (utilisée depuis un poste de développement)

## Déploiement des migrations

```bash
npm run db:deploy
```

## Insertion des données

```bash
npm run db:seed
```

---

# 9. Maintenance et exploitation

## Démarrage quotidien

### Backend

```bash
cd backend
npm run start:dev
```

### Frontend

```bash
flutter run
```

## Vérification de l'API

```bash
curl http://127.0.0.1:3000/theory/categories
```

## Construction du backend

```bash
npm run build
```

## Exécution des tests

### Backend

```bash
npm run test
npm run test:e2e
```

### Flutter

```bash
flutter test
```

## Actions de maintenance courantes

* mise à jour des dépendances 
* application des migrations Prisma 
* vérification des logs Render 
* contrôle du bon fonctionnement de l'API 
* correction des anomalies signalées

---

# 10. Assistance et gestion des incidents

Les incidents détectés par les utilisateurs doivent être centralisés dans un système de suivi.

Les anomalies peuvent être enregistrées sous forme de tickets via :

* GitHub Issues 
* Trello 

Chaque incident doit être documenté afin de faciliter sa reproduction et sa résolution.

Les informations minimales à fournir sont :

* date de détection 
* description du problème 
* environnement concerné 
* étapes de reproduction 
* niveau de gravité

---

# 11. Conclusion

Cette documentation de maintenance et d'administration a pour objectif de faciliter la prise en main technique du projet K-Boost par un développeur ou un administrateur.

Elle présente l'architecture de l'application, les technologies utilisées, l'environnement de développement, les procédures d'installation, de déploiement et de maintenance ainsi que les méthodes de gestion des incidents.

L'ensemble de ces informations permet d'assurer la continuité du projet et de faciliter son évolution future.
