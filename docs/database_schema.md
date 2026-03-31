# 🗄️ Database Schema – Language Learning App

Cette base de données est conçue pour une application d’apprentissage de langues scalable et évolutive.

Elle est organisée en modules :

1. Apprentissage (MVP)
2. Progression utilisateur
3. Social
4. Gamification
5. IA pédagogique
6. Map de progression

Base de données recommandée :

PostgreSQL

---

# MODULE 1 — APPRENTISSAGE (MVP)

Ce module est celui utilisé pour la première version de l’application.

Il gère :

- vocabulaire
- théorie
- exercices
- notes

---

# Table Categories

Catégories grammaticales.

Permet de classer les mots pour générer des exercices logiques.

fields

id  
name  
description  

exemples

subject  
object  
action  
place  
time  
adjective  
particle  
expression  

---

# Table Lessons

Structure pédagogique des cours.

fields

id  
title  
description  
level  
order_index  

exemple

Lesson 1  
Hangul Basics

---

# Table Words

Contient tout le vocabulaire.

fields

id  
word  
translation  
romanization  
category_id  
definition  
difficulty  
audio_url  
lesson_id  

exemple

word : 먹다  
translation : manger  
romanization : meokda  
category : action  

---

# Table Particles

Particules grammaticales.

fields

id  
particle  
description  
example  

exemple

을 / 를  
object particle  

---

# Table ExampleSentences

Exemples de phrases.

fields

id  
sentence  
translation  
romanization  
word_id  

Ces exemples pourront être générés par IA dans le futur.

---

# Table Exercises

Types d’exercices disponibles.

fields

id  
type  
difficulty  
lesson_id  

types

multiple_choice  
memory  
sentence_order  
fill_blank  
translation  
dictation  
grammar  

---

# Table ExerciseQuestions

Questions associées à un exercice.

fields

id  
exercise_id  
question_text  
audio_url  

---

# Table ExerciseAnswers

Réponses possibles pour une question.

fields

id  
question_id  
answer_text  
is_correct  

---

# Table Notes

Notes personnelles des utilisateurs.

fields

id  
user_id  
title  
content  
created_at  
updated_at  

---

# MODULE 2 — PROGRESSION UTILISATEUR

Permet de suivre l’apprentissage de l’utilisateur.

---

# Table Users

Stocke les utilisateurs.

fields

id  
email  
username  
password_hash  
created_at  
updated_at  

---

# Table UserProgress

Progression par leçon.

fields

id  
user_id  
lesson_id  
completed  
score  
updated_at  

---

# Table UserWords

Suivi de maîtrise des mots.

fields

id  
user_id  
word_id  
mastery_level  
last_reviewed  

mastery_level exemple

1 débutant  
2 en apprentissage  
3 maîtrisé  

---

# MODULE 3 — SOCIAL

Fonctionnalités sociales.

---

# Table Friends

Relation d’amitié entre utilisateurs.

fields

id  
user_id  
friend_id  
created_at  

---

# Table Messages

Messagerie entre utilisateurs.

fields

id  
sender_id  
receiver_id  
message  
created_at  

---

# Table Challenges

Défis entre utilisateurs.

fields

id  
challenger_id  
opponent_id  
challenge_type  
score_challenger  
score_opponent  
status  

types

oral  
écrit  
mémoire  

status

pending  
active  
completed  

---

# Table ActivityFeed

Fil d’actualité des utilisateurs.

fields

id  
user_id  
activity_type  
content  
created_at  

exemples

"Kilian a terminé la leçon 3"

"Kilian a gagné un défi"

---

# MODULE 4 — GAMIFICATION

Système de récompenses.

---

# Table Achievements

Liste des succès.

fields

id  
name  
description  
icon  

exemples

First Lesson  
100 Words Learned  
First Challenge Won  

---

# Table UserAchievements

Succès débloqués par l’utilisateur.

fields

id  
user_id  
achievement_id  
unlocked_at  

---

# MODULE 5 — IA PEDAGOGIQUE

Permet d’intégrer des fonctionnalités IA.

---

# Table AIRequests

Historique des requêtes IA.

fields

id  
user_id  
word_id  
prompt  
response  
created_at  

utilisation

explication d’un mot  
génération de phrases  

---

# MODULE 6 — MAP DE PROGRESSION

Permet de construire la carte de progression.

---

# Table Levels

Niveaux de la map.

fields

id  
name  
description  
order_index  

exemple

Level 1  
Hangul

Level 2  
Basic Grammar

---

# Table LevelLessons

Relation entre niveaux et leçons.

fields

id  
level_id  
lesson_id  

---

# RELATIONS PRINCIPALES

Users  
↓  
UserProgress  

Users  
↓  
UserWords  

Users  
↓  
Notes  

Users  
↓  
Friends  

Users  
↓  
Messages  

Lessons  
↓  
Words  

Lessons  
↓  
Exercises  

Exercises  
↓  
ExerciseQuestions  
↓  
ExerciseAnswers  

Words  
↓  
ExampleSentences  

Levels  
↓  
LevelLessons  

---

# VERSION MVP UTILISÉE POUR LA SOUTENANCE

Pour la première version de l’application nous utilisons seulement :

Categories  
Lessons  
Words  
Exercises  
ExerciseQuestions  
ExerciseAnswers  
Notes  

Toutes les données sont mockées dans l’application Flutter.

La base de données réelle sera implémentée dans une version future avec un backend NestJS et PostgreSQL.