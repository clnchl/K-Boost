# WordDetailScreen

## Rôle de l'écran

WordDetailScreen affiche le detail complet d'un mot.
Il sert de base pedagogique pour comprendre un mot dans son contexte grammatical.
L'ecran recoit un wordId et charge les donnees via les viewmodels Riverpod.

## Composants UI

- AppBar avec titre Word Detail
- Etat mot:
  - loading
  - error
  - not found
- Bloc principal mot:
  - word
  - translation
  - romanization
- Informations:
  - category
  - particle
  - definition
  - difficulty
  - lessonId
- Bouton audio mock
- Bouton Voir exercices lies (navigation contextuelle)
- Section Exemples avec etats loading/data/error

## Interactions utilisateur

- Lecture du detail complet du mot
- Tap sur bouton audio (mock)
- Tap sur Voir exercices lies -> ouvre CourseScreen filtre sur la lecon du mot
- Lecture des exemples de phrase charges via usecase

## Evolutions futures

- Lecture audio reelle (TTS ou fichier)
- Exemples dynamiques generes par IA
- Affichage des variantes de conjugaison
- Lien direct vers exercices associes
