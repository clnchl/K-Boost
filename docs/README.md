# 📚 Language Learning App K-Boost

Application mobile d’apprentissage des langues conçue pour être moderne, pédagogique et évolutive.

Le projet est construit avec Flutter et suit une Clean Architecture afin d’être facilement maintenable et scalable.

L’objectif est de créer une application qui permet d’apprendre une langue (ex : coréen) avec :

- apprentissage progressif
- vocabulaire structuré
- exercices interactifs
- compréhension grammaticale
- génération d’exemples par IA
- système de notes personnelles
- progression gamifiée

---

# 🎯 Objectif du projet

Créer une application mobile permettant d'apprendre une langue avec :

- vocabulaire organisé
- compréhension de la structure grammaticale
- exercices variés adaptés au cerveau humain
- progression logique
- assistance pédagogique via IA

L’application est pensée pour évoluer vers :

- fonctionnalités sociales
- IA pédagogique avancée
- progression personnalisée
- génération intelligente d’exercices

---

# ⚙️ Technologies utilisées

Frontend

Flutter  
Dart

Architecture

Clean Architecture  
MVVM

State Management

Riverpod

Backend futur

NodeJS  
NestJS

Base de données future

PostgreSQL

IA future

API OpenAI ou autre LLM

---

# ⚠️ Version actuelle du projet

Pour la première version :

- aucun backend
- aucune base de données connectée

Toutes les données sont mockées.

Cependant les modèles doivent être conçus comme s'ils étaient déjà connectés à une base de données afin de faciliter l’évolution future.

---

# 📦 Navigation de l'application

Structure principale :

Application  
│  
├ Accueil (map de progression)  
│  
├ Apprentissage  
│   ├ Théorie  
│   ├ Cours  
│   ├ Notes  
│  
├ Social (future feature)  
│  
└ Profil  

Pour l’instant seule la section Apprentissage est développée.

---

# 🧱 Architecture Flutter

Structure recommandée :

lib  
│  
├ core  
│   ├ constants  
│   ├ theme  
│   ├ utils  
│  
├ features  
│  
│   └ learning  
│       │  
│       ├ data  
│       │   ├ models  
│       │   ├ datasources  
│       │   └ repositories_impl  
│       │  
│       ├ domain  
│       │   ├ entities  
│       │   ├ repositories  
│       │   └ usecases  
│       │  
│       └ presentation  
│           ├ screens  
│           ├ widgets  
│           └ viewmodels  

---

# 🔁 Clean Architecture Flow

Les données doivent suivre ce flux :

UI  
↓  
ViewModel  
↓  
UseCase  
↓  
Repository  
↓  
DataSource  

Cela permet :

- découplage
- testabilité
- évolutivité
- remplacement facile du backend

---

# 🇰🇷 Logique pédagogique pour le coréen

L’apprentissage du coréen doit suivre une progression logique.

Ordre recommandé :

1. Hangul (alphabet)
2. Structure des phrases
3. Catégories grammaticales
4. Vocabulaire
5. Construction de phrases
6. Exercices

---

# 🔤 Apprentissage du Hangul

Avant d’apprendre des mots, l’utilisateur doit apprendre à lire le Hangul.

Objectif :

Pouvoir lire n’importe quel mot coréen même sans connaître la traduction.

Étapes :

- consonnes
- voyelles
- blocs syllabiques
- prononciation
- batchim (consonnes finales)

Exemple :

가 → ga  
강 → gang  

Objectif final :

Pouvoir lire :

안녕하세요

---

# 🧠 Structure des phrases coréennes

Le coréen utilise la structure :

Sujet → Objet → Verbe

Exemple :

나는 밥을 먹는다

Sujet : 나는  
Objet : 밥을  
Verbe : 먹는다  

Traduction :

Je mange du riz.

Comprendre cette structure dès le début est essentiel.

---

# 🧩 Catégories grammaticales

Chaque mot doit être classé dans une catégorie grammaticale.

Catégories principales :

subject  
object  
action (verbe)  
place  
time  
adjective  
particle  
expression  

Exemples :

사람 → subject  
밥 → object  
먹다 → action  
학교 → place  
오늘 → time  

Ces catégories permettent de :

- générer des exercices logiques
- construire des phrases
- comprendre la grammaire

---

# 📘 Théorie (Vocabulaire)

La section Théorie correspond au vocabulaire.

Les mots sont affichés sous forme de cards.

Chaque WordCard affiche :

- mot
- traduction
- romanisation

Cliquer sur la card ouvre :

WordDetailScreen

---

# 📖 Word Detail Screen

Affiche :

- mot
- traduction
- romanisation
- catégorie grammaticale
- particule associée
- différent temps 
- définition
- bouton audio
- exemples de phrase

Les exemples de phrase sont générés dynamiquement par IA dans le futur.

Pour l’instant ils sont mockés.

---

# 🧠 Système d’exercices

Les exercices doivent suivre une progression cognitive.

Ordre recommandé :

1 reconnaissance  
2 association  
3 compréhension  
4 production  
5 logique grammaticale  

---

# 🧪 Types d’exercices

Types d’exercices supportés :

multiple_choice  
audio_choice  
memory  
sentence_order  
fill_blank  
translation  
writing  
dictation  
grammar  

Exemples :

cliquer sur la bonne card  
associer mot et traduction  
remettre une phrase dans l’ordre  
compléter une phrase avec une particule  
écrire ce que l’on entend  

---

# 📚 Cours (exercices)

La section Cours contient les exercices.

Les exercices sont générés à partir des mots stockés dans l’application.

Exemples :

traduction  
réorganisation de phrase  
dictée  
compléter une phrase  

---

# 📝 Notes

La section Notes fonctionne comme Apple Notes.

Fonctionnalités :

- créer une note
- modifier une note
- supprimer une note
- voir liste de notes

L’utilisateur peut écrire librement :

- phrases
- traductions
- mémos

---

# 📊 Mock Data

Pour le développement :

Créer :

mockWords  
mockExercises  
mockNotes  

Les mocks doivent respecter la structure future de la base de données.

---

# 🤖 IA pédagogique (future)

Deux utilisations principales :

Correction d’erreurs

Si l’utilisateur se trompe, l’IA peut expliquer le mot.

Exemples de phrases

L’utilisateur peut générer des phrases avec un mot.

Exemple de prompt :

Donne 3 exemples de phrases utilisant le mot : {word}

Inclure :

- phrase coréenne
- romanisation
- traduction

---

# 📄 Documentation

Créer dossier :

docs/screens

Créer fichiers :

learning_screen.md  
theory_screen.md  
word_detail_screen.md  
course_screen.md  
notes_screen.md  

Chaque fichier doit expliquer :

- rôle de l’écran
- composants UI
- interactions utilisateur
- évolutions futures

---

# 🧾 Development Log

Créer fichier :

docs/development_log.md

Contenu :

- fichiers créés
- décisions d’architecture
- choix techniques
- problèmes rencontrés

---

# 🚀 Objectif de la première étape

Créer la feature :

Apprentissage

Avec les écrans :

LearningScreen  
TheoryScreen  
WordDetailScreen  
CourseScreen  
NotesScreen  

---

# 📌 Ordre de développement

1 créer structure dossiers  
2 créer entités  
3 créer modèles  
4 créer mock data  
5 créer écrans de base  

Puis arrêter et demander validatio