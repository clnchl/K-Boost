import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/note.dart';
import '../../domain/usecases/delete_note_usecase.dart';
import '../../domain/usecases/get_notes_usecase.dart';
import '../../domain/usecases/upsert_note_usecase.dart';
import 'learning_providers.dart';

final notesViewModelProvider =
    StateNotifierProvider<NotesViewModel, AsyncValue<List<NoteEntity>>>(
  (Ref ref) {
    final NotesViewModel viewModel = NotesViewModel(
      getNotesUseCase: ref.watch(getNotesUseCaseProvider),
      upsertNoteUseCase: ref.watch(upsertNoteUseCaseProvider),
      deleteNoteUseCase: ref.watch(deleteNoteUseCaseProvider),
    );
    viewModel.loadNotes();
    return viewModel;
  },
);

class NotesViewModel extends StateNotifier<AsyncValue<List<NoteEntity>>> {
  NotesViewModel({
    required GetNotesUseCase getNotesUseCase,
    required UpsertNoteUseCase upsertNoteUseCase,
    required DeleteNoteUseCase deleteNoteUseCase,
  })  : _getNotesUseCase = getNotesUseCase,
        _upsertNoteUseCase = upsertNoteUseCase,
        _deleteNoteUseCase = deleteNoteUseCase,
        super(const AsyncValue<List<NoteEntity>>.loading());

  final GetNotesUseCase _getNotesUseCase;
  final UpsertNoteUseCase _upsertNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  Future<void> loadNotes() async {
    state = const AsyncValue<List<NoteEntity>>.loading();

    try {
      final List<NoteEntity> notes = await _getNotesUseCase();
      state = AsyncValue<List<NoteEntity>>.data(notes);
    } catch (error, stackTrace) {
      state = AsyncValue<List<NoteEntity>>.error(error, stackTrace);
    }
  }

  Future<void> createNote({
    required String userId,
    required String title,
    required String content,
  }) async {
    final DateTime now = DateTime.now();

    final NoteEntity note = NoteEntity(
      id: now.microsecondsSinceEpoch.toString(),
      userId: userId,
      title: title.isEmpty ? 'Sans titre' : title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );

    await _upsertNoteUseCase(note);
    await loadNotes();
  }

  Future<void> updateNote({
    required NoteEntity existing,
    required String title,
    required String content,
  }) async {
    final NoteEntity note = NoteEntity(
      id: existing.id,
      userId: existing.userId,
      title: title.isEmpty ? 'Sans titre' : title,
      content: content,
      createdAt: existing.createdAt,
      updatedAt: DateTime.now(),
    );

    await _upsertNoteUseCase(note);
    await loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await _deleteNoteUseCase(id);
    await loadNotes();
  }
}
