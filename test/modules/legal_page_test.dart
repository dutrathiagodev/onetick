import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/main/auth_flow.dart';

import '../helpers/pump_helpers.dart';
import '../helpers/test_setup.dart';

void main() {
  setUp(setUpTestDependencies);

  Future<void> openLogin(WidgetTester tester) async {
    useFigmaViewport(tester);
    await loadTestFonts();
    await tester.pumpWidget(testApp(const AuthFlow()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Já tem uma conta? Entrar').hitTestable());
    await tester.pumpAndSettle();
  }

  for (final (key, title) in [
    ('footer_privacy', 'Política de Privacidade'),
    ('footer_terms', 'Termos de Uso'),
  ]) {
    testWidgets('$title opens from the login footer and goes back', (
      tester,
    ) async {
      await openLogin(tester);
      await tester.ensureVisible(find.byKey(Key(key)));
      await tester.tap(find.byKey(Key(key)));
      await tester.pumpAndSettle();

      expect(find.text(title), findsOneWidget);
      expect(find.textContaining('Atualizado em'), findsOneWidget);

      await tester.tap(find.byKey(const Key('legal_back')));
      await tester.pumpAndSettle();
      expect(find.text(title), findsNothing);
      expect(find.byKey(Key(key)), findsOneWidget);
    });
  }
}
