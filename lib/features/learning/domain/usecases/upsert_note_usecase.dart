import '../entities/note.dart';
import '../repositories/note_repository.dart';

class UpsertNoteUseCase {
  const UpsertNoteUseCase(this._repository);

  final NoteRepository _repository;

  Future<void> call(NoteEntity note) {
    return _repository.upsertNote(note);
  }
}
