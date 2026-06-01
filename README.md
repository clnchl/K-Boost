# K-Boost
Application Flutter d'apprentissage des langues.

## Prérequis

- Flutter SDK (stable)
- Dart (inclus avec Flutter)
- Android Studio ou VS Code
- Pour iOS (macOS uniquement) : Xcode

## Démarrage rapide (mobile)

1. Récupérer le projet
2. Installer les dépendances
3. Lancer l'application

```bash
flutter pub get
flutter run
```

## Backend (NestJS)

Le backend se trouve dans le dossier `backend/` et expose une API REST consommée par l'application mobile.

Commandes courantes :

```bash
# depuis la racine du repo
cd backend
npm install
npm run start:dev    # développement (watch)

# ou en production
npm run start:prod
```

Vérifier une route (depuis l'hôte) :

```bash
curl http://127.0.0.1:3000/theory/categories
```

Tests backend :

```bash
# unitaires
npm run test

# e2e (configuration: test/jest-e2e.json)
npm run test:e2e

# couverture
npm run test:cov
```

## Base de données (PostgreSQL + Prisma)

Pré-requis : PostgreSQL installé et démarré.

Initialisation rapide (dev) :

```bash
cd backend
cp .env.example .env   # puis éditer DATABASE_URL
npm install
npm run db:migrate
npm run db:seed
```

Notes :
- L'API lit **uniquement PostgreSQL** (Prisma) à l'exécution.
- Les fichiers `backend/src/theory/data/*.json` servent **seulement** au seed (`npm run db:seed`).
- Connexion : `DATABASE_URL` dans `backend/.env`.

## Organisation du projet

- `lib/` : code Flutter (features, core, ui)
- `android/`, `ios/`, `macos/`, `windows/`, `linux/`, `web/` : plateformes natives
- `backend/` : API NestJS (TypeScript)
- `test/` : tests Dart/Flutter

