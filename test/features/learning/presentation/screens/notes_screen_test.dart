import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/learning/presentation/screens/notes_screen.dart';

void main() {
  Widget buildTestApp() {
    return const ProviderScope(child: MaterialApp(home: NotesScreen()));
  }

  group('NotesScreen dialog lifecycle', () {
    testWidgets('can create a note without controller disposal exception', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pump();
      await tester.pump();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Nouvelle note'), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Titre test');
      await tester.enterText(find.byType(TextField).at(1), 'Contenu test');

      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      expect(find.text('Nouvelle note'), findsNothing);
      expect(find.text('Titre test'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('can edit a note without controller disposal exception', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pump();
      await tester.pump();

      await tester.tap(find.byIcon(Icons.edit_rounded).first);
      await tester.pumpAndSettle();

      expect(find.text('Modifier la note'), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Titre modifie');
      await tester.enterText(find.byType(TextField).at(1), 'Contenu modifie');

      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      expect(find.text('Modifier la note'), findsNothing);
      expect(find.text('Titre modifie'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
