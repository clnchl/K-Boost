import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../test_fakes.dart';
import '../../../../../lib/features/learning/domain/entities/note.dart';
import '../../../../../lib/features/learning/domain/usecases/delete_note_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/get_notes_usecase.dart';
import '../../../../../lib/features/learning/domain/usecases/upsert_note_usecase.dart';
import '../../../../../lib/features/learning/presentation/viewmodels/notes_viewmodel.dart';

void main() {
  NotesViewModel buildViewModel(FakeNoteRepository repository) {
    return NotesViewModel(
      getNotesUseCase: GetNotesUseCase(repository),
      upsertNoteUseCase: UpsertNoteUseCase(repository),
      deleteNoteUseCase: DeleteNoteUseCase(repository),
    );
  }

  group('NotesViewModel', () {
    test('loadNotes exposes AsyncData when successful', () async {
      final FakeNoteRepository repository =
          FakeNoteRepository(initialNotes: [sampleNote()]);
      final NotesViewModel viewModel = buildViewModel(repository);

      await viewModel.loadNotes();

        expect(viewModel.state, isA<AsyncData<List<NoteEntity>>>());
        final AsyncData<List<NoteEntity>> state =
          viewModel.state as AsyncData<List<NoteEntity>>;
        expect(state.value, hasLength(1));
    });

    test('createNote stores note and reloads list', () async {
      final FakeNoteRepository repository = FakeNoteRepository();
      final NotesViewModel viewModel = buildViewModel(repository);

      await viewModel.createNote(userId: 'u1', title: '', content: 'memo');

      expect(repository.upsertedNote, isNotNull);
      expect(repository.upsertedNote!.title, 'Sans titre');
        expect(viewModel.state, isA<AsyncData<List<NoteEntity>>>());
        final AsyncData<List<NoteEntity>> state =
          viewModel.state as AsyncData<List<NoteEntity>>;
        expect(state.value, hasLength(1));
    });

    test('updateNote keeps id/createdAt and refreshes state', () async {
      final existing = sampleNote(
        id: 'n1',
        title: 'Old',
        content: 'old',
        createdAt: DateTime(2026, 3, 31, 8, 0),
        updatedAt: DateTime(2026, 3, 31, 8, 0),
      );
      final FakeNoteRepository repository =
          FakeNoteRepository(initialNotes: [existing]);
      final NotesViewModel viewModel = buildViewModel(repository);

      await viewModel.updateNote(
        existing: existing,
        title: 'New',
        content: 'new content',
      );

      expect(repository.upsertedNote, isNotNull);
      expect(repository.upsertedNote!.id, existing.id);
      expect(repository.upsertedNote!.createdAt, existing.createdAt);
      expect(
        repository.upsertedNote!.updatedAt.isBefore(existing.updatedAt),
        isFalse,
      );
      expect(viewModel.state, isA<AsyncData<List<NoteEntity>>>());
      final AsyncData<List<NoteEntity>> state =
          viewModel.state as AsyncData<List<NoteEntity>>;
      expect(state.value.first.title, 'New');
    });

    test('deleteNote removes note and refreshes state', () async {
      final FakeNoteRepository repository = FakeNoteRepository(
        initialNotes: [sampleNote(id: 'n1'), sampleNote(id: 'n2')],
      );
      final NotesViewModel viewModel = buildViewModel(repository);

      await viewModel.deleteNote('n1');

      expect(repository.deletedId, 'n1');
      expect(viewModel.state, isA<AsyncData<List<NoteEntity>>>());
      final AsyncData<List<NoteEntity>> state =
          viewModel.state as AsyncData<List<NoteEntity>>;
      expect(state.value, hasLength(1));
      expect(state.value.first.id, 'n2');
    });
  });
}
