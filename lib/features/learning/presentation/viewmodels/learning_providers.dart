import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/learning_local_datasource.dart';
import '../../data/datasources/mock_particles.dart';
import '../../data/repositories_impl/exercise_repository_impl.dart';
import '../../data/repositories_impl/example_sentence_repository_impl.dart';
import '../../data/repositories_impl/note_repository_impl.dart';
import '../../data/repositories_impl/theme_repository_impl.dart';
import '../../data/repositories_impl/word_repository_impl.dart';
import '../../domain/entities/particle_info.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../../domain/repositories/example_sentence_repository.dart';
import '../../domain/repositories/note_repository.dart';
import '../../domain/repositories/theme_repository.dart';
import '../../domain/repositories/word_repository.dart';
import '../../domain/usecases/delete_note_usecase.dart';
import '../../domain/usecases/get_exercises_usecase.dart';
import '../../domain/usecases/get_notes_usecase.dart';
import '../../domain/usecases/get_themes_usecase.dart';
import '../../domain/usecases/get_word_by_id_usecase.dart';
import '../../domain/usecases/get_word_examples_usecase.dart';
import '../../domain/usecases/get_words_usecase.dart';
import '../../domain/usecases/upsert_note_usecase.dart';

final learningLocalDatasourceProvider = Provider<LearningLocalDatasource>(
  (Ref ref) => LearningLocalDatasourceImpl(),
);

final wordRepositoryProvider = Provider<WordRepository>(
  (Ref ref) => WordRepositoryImpl(ref.watch(learningLocalDatasourceProvider)),
);

final exerciseRepositoryProvider = Provider<ExerciseRepository>(
  (Ref ref) =>
      ExerciseRepositoryImpl(ref.watch(learningLocalDatasourceProvider)),
);

final themeRepositoryProvider = Provider<ThemeRepository>(
  (Ref ref) => ThemeRepositoryImpl(ref.watch(learningLocalDatasourceProvider)),
);

final noteRepositoryProvider = Provider<NoteRepository>(
  (Ref ref) => NoteRepositoryImpl(ref.watch(learningLocalDatasourceProvider)),
);

final exampleSentenceRepositoryProvider = Provider<ExampleSentenceRepository>(
  (Ref ref) =>
      ExampleSentenceRepositoryImpl(ref.watch(learningLocalDatasourceProvider)),
);

final getWordsUseCaseProvider = Provider<GetWordsUseCase>(
  (Ref ref) => GetWordsUseCase(ref.watch(wordRepositoryProvider)),
);

final getWordByIdUseCaseProvider = Provider<GetWordByIdUseCase>(
  (Ref ref) => GetWordByIdUseCase(ref.watch(wordRepositoryProvider)),
);

final getExercisesUseCaseProvider = Provider<GetExercisesUseCase>(
  (Ref ref) => GetExercisesUseCase(ref.watch(exerciseRepositoryProvider)),
);

final getThemesUseCaseProvider = Provider<GetThemesUseCase>(
  (Ref ref) => GetThemesUseCase(ref.watch(themeRepositoryProvider)),
);

final getNotesUseCaseProvider = Provider<GetNotesUseCase>(
  (Ref ref) => GetNotesUseCase(ref.watch(noteRepositoryProvider)),
);

final getWordExamplesUseCaseProvider = Provider<GetWordExamplesUseCase>(
  (Ref ref) =>
      GetWordExamplesUseCase(ref.watch(exampleSentenceRepositoryProvider)),
);

final upsertNoteUseCaseProvider = Provider<UpsertNoteUseCase>(
  (Ref ref) => UpsertNoteUseCase(ref.watch(noteRepositoryProvider)),
);

final deleteNoteUseCaseProvider = Provider<DeleteNoteUseCase>(
  (Ref ref) => DeleteNoteUseCase(ref.watch(noteRepositoryProvider)),
);

final particleInfoByFormProvider = Provider<Map<String, ParticleInfoEntity>>(
  (Ref ref) => mockKoreanParticlesByForm,
);
