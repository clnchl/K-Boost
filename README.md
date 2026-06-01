# K-Boost

Application Flutter + API NestJS + PostgreSQL.

Architecture : [`expliquation.md`](./expliquation.md)

---

## Vérifier les prérequis

```bash
flutter --version
node --version
npm --version
psql --version
```

---

## Installation — première fois

Exécuter **dans cet ordre**. Terminal 1 pour PostgreSQL + backend, terminal 2 pour Flutter.

> **Base de données :** ton collègue ne recrée pas la BDD à chaque démarrage.
> - `createdb` + `migrate` + `seed` → **une seule fois** sur sa machine (premier clone).
> - Ensuite : seulement `npm run start:dev` + `flutter run` (voir « Démarrage au quotidien »).
> - Il refait `createdb` / `seed` seulement si la base n'existe pas ou s'il veut tout réinitialiser.

### 1. Base PostgreSQL (une seule fois)

```bash
createdb kboost
```

```bash
# Si createdb ne fonctionne pas :
psql -U postgres -c "CREATE DATABASE kboost;"
```

### 2. Backend (terminal 1 — laisser ouvert à la fin)

```bash
cd backend
npm install
cp .env.example .env
```

Éditer `backend/.env` (remplacer `USER` et `PASSWORD`) :

```bash
# macOS / Linux
nano .env
```

```bash
cd backend
npm run db:generate
npm run db:migrate
npm run db:seed
npm run start:dev
```

### 3. Vérifier l'API (autre terminal)

```bash
curl http://127.0.0.1:3000/theory/categories
```

### 4. Flutter (terminal 2 — racine du projet)

```bash
cd ..
flutter pub get
flutter run
```

---

## Démarrage au quotidien

**Terminal 1 — API**

```bash
cd backend
npm run start:dev
```

**Terminal 2 — Flutter**

```bash
flutter run
```

---

## Commandes utiles

### Backend

```bash
cd backend
npm run start:dev
npm run build
npm run db:generate
npm run db:migrate
npm run db:seed
npm run db:studio
npm run test
npm run test:e2e
```

### Flutter

```bash
flutter pub get
flutter run
flutter test
```

---

## Dépannage

```bash
# API ne répond pas
curl http://127.0.0.1:3000/theory/categories

# Base vide → re-seed
cd backend
npm run db:seed

# Re-migrer + seed
cd backend
npm run db:migrate
npm run db:seed
```

---

## Organisation

```
lib/           → Flutter
backend/       → NestJS + Prisma
expliquation.md
```
