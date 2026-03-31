import 'package:flutter_test/flutter_test.dart';

import 'package:k_boost/main.dart';

void main() {
  testWidgets('KBoost app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KBoostApp());

    expect(find.text('Apprentissage'), findsOneWidget);
    expect(find.text('Theorie'), findsOneWidget);
    expect(find.text('Cours'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
  });
}
