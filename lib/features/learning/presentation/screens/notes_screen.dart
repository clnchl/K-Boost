import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/note.dart';
import '../viewmodels/notes_viewmodel.dart';
import '../widgets/note_card.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<NoteEntity>> notesState = ref.watch(
      notesViewModelProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openNoteDialog(),
        child: const Icon(Icons.add_rounded),
      ),
      body: notesState.when(
        data: (List<NoteEntity> notes) {
          if (notes.isEmpty) {
            return const Center(child: Text('Aucune note pour le moment.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: notes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) {
              final NoteEntity note = notes[index];

              return Dismissible(
                key: ValueKey<String>(note.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  ref.read(notesViewModelProvider.notifier).deleteNote(note.id);
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.red,
                  child: const Icon(Icons.delete_rounded, color: Colors.white),
                ),
                child: NoteCard(
                  note: note,
                  onEdit: () => _openNoteDialog(initialNote: note),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Impossible de charger les notes.'),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () =>
                        ref.read(notesViewModelProvider.notifier).loadNotes(),
                    child: const Text('Reessayer'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openNoteDialog({NoteEntity? initialNote}) async {
    final _NoteDialogResult? result = await showDialog<_NoteDialogResult>(
      context: context,
      builder: (BuildContext dialogContext) {
        return _NoteEditorDialog(initialNote: initialNote);
      },
    );

    if (result == null) {
      return;
    }

    if (result.title.isEmpty && result.content.isEmpty) {
      return;
    }

    if (initialNote != null) {
      await ref
          .read(notesViewModelProvider.notifier)
          .updateNote(
            existing: initialNote,
            title: result.title,
            content: result.content,
          );
      return;
    }

    await ref
        .read(notesViewModelProvider.notifier)
        .createNote(userId: 'u1', title: result.title, content: result.content);
  }
}

class _NoteDialogResult {
  const _NoteDialogResult({required this.title, required this.content});

  final String title;
  final String content;
}

class _NoteEditorDialog extends StatefulWidget {
  const _NoteEditorDialog({required this.initialNote});

  final NoteEntity? initialNote;

  @override
  State<_NoteEditorDialog> createState() => _NoteEditorDialogState();
}

class _NoteEditorDialogState extends State<_NoteEditorDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialNote?.title ?? '',
    );
    _contentController = TextEditingController(
      text: widget.initialNote?.content ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.initialNote == null ? 'Nouvelle note' : 'Modifier la note',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Contenu'),
              minLines: 3,
              maxLines: 5,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(
              _NoteDialogResult(
                title: _titleController.text.trim(),
                content: _contentController.text.trim(),
              ),
            );
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }
}
