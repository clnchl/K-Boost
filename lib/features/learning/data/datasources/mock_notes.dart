import '../models/note_model.dart';

final List<NoteModel> mockNotes = <NoteModel>[
  NoteModel(
    id: 'n1',
    userId: 'u1',
    title: 'Particules objet',
    content: '을/를 marque l objet direct dans la phrase.',
    createdAt: DateTime(2026, 3, 31, 10, 0),
    updatedAt: DateTime(2026, 3, 31, 10, 0),
  ),
  NoteModel(
    id: 'n2',
    userId: 'u1',
    title: 'Structure coreenne',
    content: 'Sujet -> Objet -> Verbe',
    createdAt: DateTime(2026, 3, 31, 10, 5),
    updatedAt: DateTime(2026, 3, 31, 10, 5),
  ),
];
