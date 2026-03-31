# Development Log

## Date

2026-03-31

## Etape

Etape 1: base de la feature Apprentissage

## Fichiers crees

### Domain entities

- lib/features/learning/domain/entities/word.dart
- lib/features/learning/domain/entities/exercise.dart
- lib/features/learning/domain/entities/note.dart

### Data models

- lib/features/learning/data/models/word_model.dart
- lib/features/learning/data/models/exercise_model.dart
- lib/features/learning/data/models/note_model.dart

### Mock data

- lib/features/learning/data/datasources/mock_words.dart
- lib/features/learning/data/datasources/mock_exercises.dart
- lib/features/learning/data/datasources/mock_notes.dart

### Presentation screens

- lib/features/learning/presentation/screens/learning_screen.dart
- lib/features/learning/presentation/screens/theory_screen.dart
- lib/features/learning/presentation/screens/word_detail_screen.dart
- lib/features/learning/presentation/screens/course_screen.dart
- lib/features/learning/presentation/screens/notes_screen.dart

### Documentation

- docs/screens/learning_screen.md
- docs/screens/theory_screen.md
- docs/screens/word_detail_screen.md
- docs/screens/course_screen.md
- docs/screens/notes_screen.md
- docs/development_log.md

## Decisions d'architecture

- Respect de la separation Clean Architecture: domain, data, presentation.
- Entites definies au niveau domain pour representer le coeur metier.
- Models data relies aux entites avec conversion JSON/Map pour preparer une source distante future.
- Ecrans MVP relies a des mocks afin d'avancer sans backend.

## Choix techniques

- Donnees mockees centralisees dans data/datasources.
- Navigation simple via MaterialPageRoute pour les ecrans de base.
- NotesScreen en StatefulWidget pour simuler les operations CRUD locales.
- Exemple de phrases coreennes inclus dans les mocks pour WordDetailScreen.

## Points a traiter a l'etape suivante

- Ajouter repositories, interfaces domain et usecases.
- Introduire Riverpod dans les viewmodels.
- Brancher une entree application pour tester la feature directement.

---

## Date

2026-03-31

## Etape

Etape 2: architecture complete et branchement Riverpod MVVM

## Fichiers crees

### Domain repositories

- lib/features/learning/domain/repositories/word_repository.dart
- lib/features/learning/domain/repositories/exercise_repository.dart
- lib/features/learning/domain/repositories/note_repository.dart

### Domain usecases

- lib/features/learning/domain/usecases/get_words_usecase.dart
- lib/features/learning/domain/usecases/get_exercises_usecase.dart
- lib/features/learning/domain/usecases/get_notes_usecase.dart
- lib/features/learning/domain/usecases/upsert_note_usecase.dart
- lib/features/learning/domain/usecases/delete_note_usecase.dart

### Data layer

- lib/features/learning/data/datasources/learning_local_datasource.dart
- lib/features/learning/data/repositories_impl/word_repository_impl.dart
- lib/features/learning/data/repositories_impl/exercise_repository_impl.dart
- lib/features/learning/data/repositories_impl/note_repository_impl.dart

### Presentation viewmodels

- lib/features/learning/presentation/viewmodels/learning_providers.dart
- lib/features/learning/presentation/viewmodels/theory_viewmodel.dart
- lib/features/learning/presentation/viewmodels/course_viewmodel.dart
- lib/features/learning/presentation/viewmodels/notes_viewmodel.dart

### Entree application

- lib/main.dart

## Fichiers modifies

- lib/features/learning/presentation/screens/theory_screen.dart
- lib/features/learning/presentation/screens/course_screen.dart
- lib/features/learning/presentation/screens/word_detail_screen.dart
- lib/features/learning/presentation/screens/notes_screen.dart
- docs/development_log.md

## Decisions d'architecture

- Injection de dependances via providers Riverpod centralises.
- Application stricte du flux Clean Architecture: UI -> ViewModel -> UseCase -> Repository -> DataSource.
- Les ecrans ne lisent plus directement les mocks (hors exemples phrases du detail mot conserves en mock local).

## Choix techniques

- Usage de StateNotifierProvider et AsyncValue pour gerer chargement/erreur/data.
- Datasource locale mutable pour simuler un repository persistant sans backend.
- Notes branchees sur un CRUD passe par usecases.

## Points a traiter a l'etape suivante

- Ajouter widgets reutilisables de presentation (WordCard, ExerciseCard, NoteCard).
- Introduire des tests unitaires pour usecases et viewmodels.
- Isoler les exemples de phrases dans une vraie couche repository/usecase dediee.

---

## Date

2026-03-31

## Etape

Etape 3: widgets de presentation reutilisables

## Fichiers crees

### Presentation widgets

- lib/features/learning/presentation/widgets/word_card.dart
- lib/features/learning/presentation/widgets/exercise_card.dart
- lib/features/learning/presentation/widgets/note_card.dart

## Fichiers modifies

- lib/features/learning/presentation/screens/theory_screen.dart
- lib/features/learning/presentation/screens/course_screen.dart
- lib/features/learning/presentation/screens/notes_screen.dart
- docs/development_log.md

## Decisions d'architecture

- Factorisation de la couche UI pour limiter la duplication dans les ecrans.
- Separation claire entre orchestration ecran (state/navigation) et rendu composant.

## Choix techniques

- WordCard dedie a l'affichage d'un mot dans TheoryScreen.
- ExerciseCard dedie a l'affichage d'un exercice dans CourseScreen.
- NoteCard dedie au rendu d'une note; suppression conservee dans Dismissible au niveau ecran.

## Points a traiter a l'etape suivante

- Ajouter des tests unitaires pour usecases et viewmodels.
- Isoler les exemples de phrases dans une couche data/repository dediee.

---

## Date

2026-03-31

## Etape

Etape 4: tests unitaires usecases et viewmodels

## Fichiers crees

### Test doubles

- test/features/learning/test_fakes.dart

### Tests usecases

- test/features/learning/domain/usecases/learning_usecases_test.dart

### Tests viewmodels

- test/features/learning/presentation/viewmodels/theory_course_viewmodels_test.dart
- test/features/learning/presentation/viewmodels/notes_viewmodel_test.dart

## Decisions d'architecture

- Utilisation de fakes maison (sans dependance de mocking) pour garder des tests lisibles.
- Ciblage des comportements metier essentiels: chargement, propagation erreurs, create/update/delete note.

## Choix techniques

- Assertions centrees sur AsyncValue (hasValue/hasError).
- Verification des effets secondaires repository (upsertedNote, deletedId) pour valider le flux ViewModel -> UseCase -> Repository.

## Points a traiter a l'etape suivante

- Isoler les exemples de phrases dans une couche repository/usecase dediee.
- Ajouter des tests d'integration de navigation entre ecrans.

---

## Date

2026-03-31

## Etape

Etape 5: isolation des exemples de phrases (WordDetail)

## Fichiers crees

### Domain exemples

- lib/features/learning/domain/entities/example_sentence.dart
- lib/features/learning/domain/repositories/example_sentence_repository.dart
- lib/features/learning/domain/usecases/get_word_examples_usecase.dart

### Data exemples

- lib/features/learning/data/models/example_sentence_model.dart
- lib/features/learning/data/repositories_impl/example_sentence_repository_impl.dart

### ViewModel detail mot

- lib/features/learning/presentation/viewmodels/word_detail_viewmodel.dart

### Tests ajoutes

- test/features/learning/presentation/viewmodels/word_detail_viewmodel_test.dart

## Fichiers modifies

- lib/features/learning/data/datasources/mock_words.dart
- lib/features/learning/data/datasources/learning_local_datasource.dart
- lib/features/learning/presentation/viewmodels/learning_providers.dart
- lib/features/learning/presentation/screens/word_detail_screen.dart
- test/features/learning/test_fakes.dart
- test/features/learning/domain/usecases/learning_usecases_test.dart
- docs/development_log.md

## Decisions d'architecture

- Suppression de la lecture directe des exemples mockes depuis l'ecran WordDetail.
- Application complete du flux UI -> ViewModel -> UseCase -> Repository -> DataSource pour les exemples.

## Choix techniques

- ViewModel family base sur wordId pour charger les exemples par mot.
- Reuse des mocks existants, mais types data alignes sur un vrai model de domaine.

## Points a traiter a l'etape suivante

- Ajouter des tests d'integration widget pour WordDetailScreen (loading/data/error).
- Ajouter un usecase pour recuperer un mot par id depuis la couche domain.

---

## Date

2026-03-31

## Etape

Etape 6: tests widget WordDetailScreen

## Fichiers crees

- test/features/learning/presentation/screens/word_detail_screen_test.dart

## Decisions d'architecture

- Validation de l'UI du detail mot au niveau widget sans dependre du backend.
- Surcharge du provider `getWordExamplesUseCaseProvider` pour piloter les scenarios de test.

## Choix techniques

- 3 cas testes: loading, data, error.
- Usage d'un repository de test bloquant pour verifier l'etat loading.
- Execution de `flutter test` ciblee sur le fichier d'ecran detail.

## Resultat

- Tous les tests de `word_detail_screen_test.dart` passent.

## Points a traiter a l'etape suivante

- Ajouter un usecase pour recuperer un mot par id depuis la couche domain.

---

## Date

2026-03-31

## Etape

Etape 7: usecase getWordById

## Fichiers crees

- lib/features/learning/domain/usecases/get_word_by_id_usecase.dart

## Fichiers modifies

- lib/features/learning/presentation/viewmodels/learning_providers.dart
- test/features/learning/domain/usecases/learning_usecases_test.dart
- docs/development_log.md

## Decisions d'architecture

- Exposition explicite d'un usecase unitaire pour recuperer un mot par identifiant.
- Conservation de l'acces repository au niveau domain pour garder la cohesion du flux Clean Architecture.

## Choix techniques

- Injection Riverpod via `getWordByIdUseCaseProvider`.
- Ajout de 2 tests: cas found et not found.

## Resultat

- Tests usecases executes avec succes: 8/8 passent.

## Points a traiter a l'etape suivante

- Brancher ce usecase dans un ViewModel dedie si un ecran necessite un fetch par id.

---

## Date

2026-03-31

## Etape

Etape 8: branchement WordDetail par identifiant

## Fichiers crees

- lib/features/learning/presentation/viewmodels/word_by_id_viewmodel.dart

## Fichiers modifies

- lib/features/learning/presentation/screens/theory_screen.dart
- lib/features/learning/presentation/screens/word_detail_screen.dart
- test/features/learning/presentation/screens/word_detail_screen_test.dart
- docs/screens/word_detail_screen.md
- docs/development_log.md

## Decisions d'architecture

- Navigation Theory -> WordDetail basee sur un `wordId` plutot que sur un objet complet.
- Chargement du mot via `WordByIdViewModel` et usecase `GetWordByIdUseCase`.
- Separation conservee entre le state du mot et le state des exemples.

## Choix techniques

- Nouvelle signature ecran: `WordDetailScreen(wordId: ...)`.
- Ajout des etats explicites loading/error/not-found pour le mot.
- Mise a jour des widget tests avec override de `getWordByIdUseCaseProvider`.

## Resultat

- Analyse Dart/Flutter: aucune erreur.
- Tests learning executes avec succes: 21/21 passent.

## Points a traiter a l'etape suivante

- Ajouter un test widget specifique pour le cas `Mot introuvable.`.
- Evaluer une navigation contextuelle vers des exercices lies au mot.

---

## Date

2026-03-31

## Etape

Etape 9: test widget du cas Mot introuvable

## Fichiers modifies

- test/features/learning/presentation/screens/word_detail_screen_test.dart
- docs/development_log.md

## Decisions d'architecture

- Validation explicite du cas metier ou l'id mot ne correspond a aucune entree.
- Conservation du comportement UX avec message utilisateur + action Reessayer.

## Choix techniques

- Ajout d'un helper de test dedie a un repository de mots vide.
- Ajout d'un test widget verifiant `Mot introuvable.` et le bouton `Reessayer`.

## Resultat

- Tests WordDetailScreen: 4/4 passent.
- Tests learning executes avec succes: 22/22 passent.

## Points a traiter a l'etape suivante

- Evaluer une navigation contextuelle vers des exercices lies au mot.

---

## Date

2026-03-31

## Etape

Etape 10: navigation contextuelle WordDetail -> Cours lies

## Fichiers crees

- test/features/learning/presentation/screens/course_screen_test.dart

## Fichiers modifies

- lib/features/learning/presentation/screens/course_screen.dart
- lib/features/learning/presentation/screens/word_detail_screen.dart
- docs/screens/course_screen.md
- docs/screens/word_detail_screen.md
- docs/development_log.md

## Decisions d'architecture

- Reutilisation de `CourseScreen` pour un mode standard et un mode contextuel filtre.
- Le lien detail mot -> exercices s'appuie sur `lessonId` pour rester coherent avec les donnees actuelles.

## Choix techniques

- Ajout des parametres optionnels `lessonIdFilter` et `sourceWord` dans `CourseScreen`.
- Ajout d'un bouton `Voir exercices lies` dans `WordDetailScreen`.
- Ajout de tests widget pour valider le filtrage et le cas sans resultat.

## Resultat

- Tests CourseScreen: 2/2 passent.
- Tests learning executes avec succes.

## Points a traiter a l'etape suivante

- Ajouter une navigation vers un type d'exercice specifique (execution de l'exercice).

---

## Date

2026-03-31

## Etape

Etape 11: execution d'exercice depuis Cours

## Fichiers crees

- lib/features/learning/presentation/screens/exercise_execution_screen.dart
- test/features/learning/presentation/screens/exercise_execution_screen_test.dart
- docs/screens/exercise_execution_screen.md

## Fichiers modifies

- lib/features/learning/presentation/screens/course_screen.dart
- lib/features/learning/presentation/widgets/exercise_card.dart
- test/features/learning/presentation/screens/course_screen_test.dart
- docs/screens/course_screen.md
- docs/development_log.md

## Decisions d'architecture

- Navigation explicite CourseScreen -> ExerciseExecutionScreen via tap sur carte exercice.
- Ecran d'execution MVP isole pour preparer l'extension future par type d'exercice.

## Choix techniques

- `ExerciseCard` rendue interactive via callback `onTap` optionnel.
- `ExerciseExecutionScreen` en StatefulWidget pour gerer selection, validation et feedback.
- Tests widget ajoutes pour navigation et cas correct/incorrect.

## Resultat

- Tests CourseScreen: 3/3 passent.
- Tests ExerciseExecutionScreen: 2/2 passent.

## Points a traiter a l'etape suivante

- Ajouter un moteur de scoring (points/reussite) sur l'execution d'exercice.

---

## Date

2026-03-31

## Etape

Etape 12: moteur de scoring session exercice

## Fichiers crees

- lib/features/learning/presentation/viewmodels/exercise_score_viewmodel.dart
- test/features/learning/presentation/viewmodels/exercise_score_viewmodel_test.dart

## Fichiers modifies

- lib/features/learning/presentation/screens/exercise_execution_screen.dart
- test/features/learning/presentation/screens/exercise_execution_screen_test.dart
- docs/screens/exercise_execution_screen.md
- docs/development_log.md

## Decisions d'architecture

- Score de session centralise dans un ViewModel Riverpod dedie pour separer logique et UI.
- Mise a jour du score lors de chaque validation de reponse.

## Choix techniques

- Etat score: `totalPoints`, `totalAttempts`, `successAttempts`, `successRate`.
- Barreme MVP: +10 points par reponse correcte, 0 sinon.
- Action de reset score exposee dans l'AppBar de l'ecran d'execution.

## Resultat

- Tests ExerciseScoreViewModel: 4/4 passent.
- Tests ExerciseExecutionScreen: 2/2 passent.

## Points a traiter a l'etape suivante

- Persister le score de session dans les notes/progression utilisateur locale.

---

## Date

2026-03-31

## Etape

Etape 13: correction crash TextEditingController dans NotesScreen

## Fichiers crees

- test/features/learning/presentation/screens/notes_screen_test.dart

## Fichiers modifies

- lib/features/learning/presentation/screens/notes_screen.dart
- docs/development_log.md

## Decisions d'architecture

- Le cycle de vie des `TextEditingController` est deplace dans un dialog Stateful dedie.
- L'ecran parent ne gere plus le dispose des controllers du formulaire.

## Choix techniques

- Introduction d'un `NoteEditorDialog` interne avec `initState/dispose` propres.
- Retour des valeurs via un objet resultat (`_NoteDialogResult`) au lieu d'un booleen.
- Ajout d'un `SingleChildScrollView` dans le contenu du dialog pour eviter les debordements.

## Resultat

- Crash `TextEditingController was used after being disposed` corrige.
- Tests widget NotesScreen ajoutes pour creation et edition sans exception.

## Points a traiter a l'etape suivante

- Persister le score de session dans les notes/progression utilisateur locale.
