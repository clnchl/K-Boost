# ExerciseExecutionScreen

## Role de l'ecran

ExerciseExecutionScreen permet d'executer un exercice unitaire en mode MVP.
Il couvre le cycle selection reponse -> validation -> feedback.
Il affiche aussi un score de session (points, tentatives, reussites, taux).

## Composants UI

- AppBar avec titre Execution exercice
- Action de reinitialisation du score
- Carte Score session
- Type d'exercice
- Enonce de la question
- Liste de reponses via RadioListTile
- Bouton Valider la reponse
- Carte resultat (succes ou echec)
- Boutons Recommencer et Terminer

## Interactions utilisateur

- Selectionner une reponse
- Valider la reponse
- Lire le feedback immediat
- Consulter la progression de score en direct
- Reinitialiser le score de session
- Recommencer l'exercice
- Terminer et revenir a l'ecran Cours

## Evolutions futures

- Rendu adapte selon exercise.type
- Historique detaille des tentatives par exercice
- Timer, vies et progression par session
- Feedback pedagogique genere par IA
