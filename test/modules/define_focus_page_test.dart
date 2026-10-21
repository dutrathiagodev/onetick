import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/modules/define_focus/page/define_focus_page.dart';

import '../helpers/pump_helpers.dart';
import '../helpers/test_setup.dart';

void main() {
  setUpAll(loadTestFonts);

  Future<void> pumpPage(WidgetTester tester, {List focus = const []}) async {
    await setUpTestDependencies(focus: focus.cast());
    useFigmaViewport(tester);
    await tester.pumpWidget(testApp(const DefineFocusPage()));
    await settle(tester);
  }

  ElevatedButton? saveAsElevated(WidgetTester tester) => null;

  bool saveEnabled(WidgetTester tester) {
    final inkWell = tester.widget<InkWell>(
      find.descendant(
        of: find.byKey(const Key('define_focus_save')),
        matching: find.byType(InkWell),
      ),
    );
    return inkWell.onTap != null;
  }

  testWidgets('save is disabled while empty and counter starts at 0/60', (
    tester,
  ) async {
    await pumpPage(tester);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('/ 60'), findsOneWidget);
    expect(saveEnabled(tester), isFalse);
    expect(saveAsElevated(tester), isNull);
  });

  testWidgets('whitespace-only text keeps save disabled', (tester) async {
    await pumpPage(tester);
    await tester.enterText(
      find.byKey(const Key('define_focus_input')),
      '     ',
    );
    await settle(tester);
    expect(saveEnabled(tester), isFalse);
  });

  testWidgets('counter follows typing and input is capped at 60 chars', (
    tester,
  ) async {
    await pumpPage(tester);
    await tester.enterText(find.byKey(const Key('define_focus_input')), 'Ler');
    await settle(tester);
    expect(find.text('3'), findsOneWidget);
    expect(saveEnabled(tester), isTrue);

    await tester.enterText(
      find.byKey(const Key('define_focus_input')),
      'a' * 75,
    );
    await settle(tester);
    expect(find.text('60'), findsOneWidget);
  });

  testWidgets('suggestion chip fills the input', (tester) async {
    await pumpPage(tester);
    await tester.tap(find.byKey(const Key('suggestion_Meditar 5 min')));
    await settle(tester);
    expect(find.text('Meditar 5 min'), findsNWidgets(2)); // chip + input text
    expect(find.text('13'), findsOneWidget);
  });

  testWidgets('prefills with today\'s existing focus', (tester) async {
    await pumpPage(
      tester,
      focus: [focusOn(testNow, 'Escrever relatório', completed: false)],
    );
    expect(find.text('Escrever relatório'), findsOneWidget);
    expect(find.text('18'), findsOneWidget);
  });

  testWidgets('saving pops the page with true', (tester) async {
    await setUpTestDependencies();
    useFigmaViewport(tester);
    bool? result;
    await tester.pumpWidget(
      testApp(
        Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () async {
                  result = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(builder: (_) => const DefineFocusPage()),
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await settle(tester);
    await tester.enterText(
      find.byKey(const Key('define_focus_input')),
      'Caminhar 20 min',
    );
    await settle(tester);
    await tester.tap(find.byKey(const Key('define_focus_save')));
    await settle(tester);
    expect(result, isTrue);
    expect(find.text('open'), findsOneWidget);
  });

  testWidgets('cancel pops without saving', (tester) async {
    await setUpTestDependencies();
    useFigmaViewport(tester);
    bool? result = false;
    await tester.pumpWidget(
      testApp(
        Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(builder: (_) => const DefineFocusPage()),
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await settle(tester);
    await tester.tap(find.byKey(const Key('define_focus_cancel')));
    await settle(tester);
    expect(result, isNull);
  });
}
