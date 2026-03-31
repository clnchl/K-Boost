import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNotesUseCase {
  const GetNotesUseCase(this._repository);

  final NoteRepository _repository;

  Future<List<NoteEntity>> call() {
    return _repository.getNotes();
  }
}
