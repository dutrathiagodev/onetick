// Visual regression of every Figma frame at 440x890.
// Regenerate with: flutter test --update-goldens test/goldens
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/main/app.dart';
import 'package:onetick/main/di/service_locator.dart';
import 'package:onetick/modules/define_focus/page/define_focus_page.dart';
import 'package:onetick/modules/login/page/login_page.dart';
import 'package:onetick/modules/onboarding/page/onboarding_page.dart';
import 'package:onetick/modules/register/page/register_page.dart';

import '../helpers/pump_helpers.dart';
import '../helpers/test_setup.dart';

void main() {
  setUpAll(loadTestFonts);

  Future<void> shot(WidgetTester tester, String name) async {
    await expectLater(
      find.byType(MaterialApp).first,
      matchesGoldenFile('$name.png'),
    );
  }

  Future<void> pumpOnboarding(WidgetTester tester) async {
    await setUpTestDependencies();
    useFigmaViewport(tester);
    await tester.pumpWidget(
      testApp(OnboardingPage(onSkip: () {}, onFinish: () {}, onLogin: () {})),
    );
    await precacheAppImages(tester);
    await settle(tester);
  }

  testWidgets('onboarding 1', (tester) async {
    await pumpOnboarding(tester);
    await shot(tester, 'onboarding_1');
  });

  testWidgets('onboarding 2', (tester) async {
    await pumpOnboarding(tester);
    await tester.tap(find.text('Avançar'));
    await settle(tester);
    await shot(tester, 'onboarding_2');
  });

  testWidgets('onboarding 3', (tester) async {
    await pumpOnboarding(tester);
    await tester.tap(find.text('Avançar'));
    await settle(tester);
    await tester.tap(find.text('Avançar'));
    await settle(tester);
    await shot(tester, 'onboarding_3');
  });

  testWidgets('login', (tester) async {
    await setUpTestDependencies();
    useFigmaViewport(tester);
    await tester.pumpWidget(testApp(LoginPage(onGoToRegister: () {})));
    await settle(tester);
    await shot(tester, 'login');
  });

  testWidgets('register', (tester) async {
    await setUpTestDependencies();
    useFigmaViewport(tester);
    await tester.pumpWidget(testApp(RegisterPage(onGoToLogin: () {})));
    await settle(tester);
    await shot(tester, 'register');
  });

  testWidgets('define focus', (tester) async {
    await setUpTestDependencies();
    useFigmaViewport(tester);
    await tester.pumpWidget(testApp(const DefineFocusPage()));
    await precacheAppImages(tester);
    await settle(tester);
    await shot(tester, 'define_focus');
  });

  Future<void> pumpHome(WidgetTester tester, {required List focus}) async {
    await setUpTestDependencies(signedInUser: testUser, focus: focus.cast());
    useFigmaViewport(tester);
    await tester.pumpWidget(const OneTickApp(showLocalModeStrip: false));
    await precacheAppImages(tester);
    await settle(tester);
  }

  testWidgets('today (pending)', (tester) async {
    await pumpHome(
      tester,
      focus: [
        focusOn(
          DateTime(2024, 10, 30),
          'Beber 2L de água ao longo do dia',
          completed: false,
        ),
        for (final d in [25, 26, 27, 28, 29])
          focusOn(DateTime(2024, 10, d), 'x'),
      ],
    );
    await shot(tester, 'today_pending');
  });

  testWidgets('today (completed)', (tester) async {
    await pumpHome(
      tester,
      focus: [
        for (final d in [26, 27, 28, 29, 30])
          focusOn(DateTime(2024, 10, d), 'Beber 2L de água ao longo do dia'),
      ],
    );
    await shot(tester, 'today_completed');
  });

  testWidgets('history', (tester) async {
    const done = [
      1,
      2,
      3,
      4,
      6,
      7,
      8,
      10,
      11,
      12,
      13,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      27,
      28,
      29,
      30,
    ];
    const titles = {
      30: 'Revisão do código do checkout',
      29: 'Elaborar proposta de redesign mobile',
      28: 'Estudo de caso de usabilidade OneTick',
      27: 'Mapeamento de jornada do usuário',
      25: 'Alinhamento de tipografia e tokens',
      24: 'Planejamento das metas semanais',
    };
    await pumpHome(
      tester,
      focus: [
        for (final d in done)
          focusOn(DateTime(2024, 10, d), titles[d] ?? 'Foco $d'),
      ],
    );
    await tester.tap(find.text('Histórico').last);
    await settle(tester);
    await shot(tester, 'history');
  });

  testWidgets('settings', (tester) async {
    await pumpHome(tester, focus: const []);
    await tester.tap(find.text('Configurações').last);
    await settle(tester);
    await shot(tester, 'settings');
  });

  tearDownAll(() => getIt.reset());
}
