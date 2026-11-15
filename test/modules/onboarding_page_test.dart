import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/modules/onboarding/page/onboarding_page.dart';

import '../helpers/pump_helpers.dart';
import '../helpers/test_setup.dart';

void main() {
  setUpAll(loadTestFonts);

  late List<String> calls;

  Future<void> pumpPage(WidgetTester tester) async {
    calls = [];
    await setUpTestDependencies();
    useFigmaViewport(tester);
    await tester.pumpWidget(
      testApp(
        OnboardingPage(
          onSkip: () => calls.add('skip'),
          onFinish: () => calls.add('finish'),
          onLogin: () => calls.add('login'),
        ),
      ),
    );
    await settle(tester);
  }

  /// The active dot is the wide one (28 px); the others are 8 px.
  int activeDot(WidgetTester tester) => [
    for (var i = 0; i < 3; i++)
      if (tester.getSize(find.byKey(Key('onboarding_dot_$i'))).width > 20) i,
  ].single;

  testWidgets('walks through the 3 slides and finishes on the last CTA', (
    tester,
  ) async {
    await pumpPage(tester);
    expect(activeDot(tester), 0);
    expect(find.text('Menos ruído, mais foco'), findsOneWidget);
    expect(find.text('Avançar'), findsOneWidget);

    await tester.tap(find.text('Avançar'));
    await settle(tester);
    expect(activeDot(tester), 1);
    expect(find.text('Apenas uma prioridade'), findsOneWidget);

    await tester.tap(find.text('Avançar'));
    await settle(tester);
    expect(activeDot(tester), 2);
    expect(find.text('1 DE 3'), findsNothing);
    expect(find.text('Celebre o dia concluído'), findsOneWidget);
    expect(find.text('Começar agora'), findsOneWidget);
    expect(calls, isEmpty);

    await tester.tap(find.text('Começar agora'));
    expect(calls, ['finish']);
  });

  testWidgets('swiping moves the active dot', (tester) async {
    await pumpPage(tester);
    await tester.drag(find.byType(PageView), const Offset(-300, 0));
    await settle(tester);
    expect(activeDot(tester), 1);
  });

  testWidgets('skip and login links call back', (tester) async {
    await pumpPage(tester);
    await tester.tap(find.text('Pular'));
    await tester.tap(find.textContaining('Entrar', findRichText: true));
    expect(calls, ['skip', 'login']);
  });
}
