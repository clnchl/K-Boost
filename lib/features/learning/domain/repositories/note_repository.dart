import '../entities/note.dart';

abstract class NoteRepository {
  Future<List<NoteEntity>> getNotes();
  Future<void> upsertNote(NoteEntity note);
  Future<void> deleteNote(String id);
}
