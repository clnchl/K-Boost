import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/learning_local_datasource.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl(this._datasource);

  final LearningLocalDatasource _datasource;

  @override
  Future<List<NoteEntity>> getNotes() {
    return _datasource.fetchNotes();
  }

  @override
  Future<void> upsertNote(NoteEntity note) {
    return _datasource.upsertNote(
      NoteModel(
        id: note.id,
        userId: note.userId,
        title: note.title,
        content: note.content,
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
      ),
    );
  }

  @override
  Future<void> deleteNote(String id) {
    return _datasource.deleteNote(id);
  }
}
