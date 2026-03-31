# CourseScreen

## Rôle de l'écran

CourseScreen presente une liste d'exercices mockes pour la phase MVP.
L'objectif actuel est d'exposer la structure des exercices et de lancer une execution simple.
Il peut aussi fonctionner en mode contextuel pour afficher uniquement les exercices lies a une lecon.

## Composants UI

- AppBar avec titre Cours
- AppBar avec titre Cours ou Cours lies (mode contextuel)
- Bandeau de contexte en mode filtre (mot source + lecon)
- Liste de cards d'exercices
- Card exercice avec:
  - type
  - questionText
  - options
  - correctAnswer (affiche en mode mock)
- Navigation vers ExerciseExecutionScreen au tap sur une card

## Interactions utilisateur

- Scroll dans la liste des exercices
- Consultation des questions et options
- Filtrage automatique par lecon quand l'ecran est ouvert depuis WordDetailScreen
- Tap sur une card exercice -> ouvre ExerciseExecutionScreen

## Evolutions futures

- Support de plusieurs types d'execution selon exercise.type
- Evaluation des reponses utilisateur
- Tracking des scores et progression
- Adaptation de difficulte selon performance
