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
npm run build:render
npm run db:generate
npm run db:migrate
npm run db:deploy
npm run db:seed
npm run db:studio
npm run test
npm run test:e2e
```

### Flutter

```bash
flutter pub get
flutter run
flutter run --dart-define=USE_PROD_API=true
flutter test
```

---

## Déploiement (Render)

Le lien Render (`https://k-boost.onrender.com`) est **l’API** (NestJS), pas l’interface Flutter.

### Backend (Web Service)

- **Root directory** : `backend`
- **Build command** :

```bash
npm install && npm run build:render
```

- **Start command** :

```bash
npm run start:prod
```

### Base de données (PostgreSQL Render)

- **`DATABASE_URL` (interne)** : utilisée par le Web Service sur Render (dans l’onglet Environment du service). Elle peut ressembler à `dpg-...-a:5432` et **n’est pas** accessible depuis ton PC.
- **External Database URL (externe)** : utilisée **depuis ton PC** pour migrer/seed la base Render.

#### Seed de la base Render (une seule fois)

1. Render → PostgreSQL → *Connections* → copier **External Database URL**.
2. Depuis ton PC :

```powershell
cd backend
$env:DATABASE_URL="postgresql://..."   # External Database URL
npm run db:deploy
npm run db:seed
```

### Vérifier la prod

```bash
curl https://k-boost.onrender.com/theory/categories
```

> Render (plan gratuit) peut “sleep” : la première requête peut prendre 30–50 secondes.

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
