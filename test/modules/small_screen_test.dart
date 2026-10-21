import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/main/app.dart';
import 'package:onetick/modules/define_focus/page/define_focus_page.dart';
import 'package:onetick/modules/login/page/login_page.dart';
import 'package:onetick/modules/onboarding/page/onboarding_page.dart';
import 'package:onetick/modules/register/page/register_page.dart';

import '../helpers/pump_helpers.dart';
import '../helpers/test_setup.dart';

/// Regression: forms must scroll (never overflow) on short/narrow screens,
/// with large system text, and with the keyboard open.
void main() {
  setUpAll(loadTestFonts);

  const sizes = {
    'phone 360x640': Size(360, 640),
    'emulator 411x780': Size(411, 780),
    'tiny 320x480': Size(320, 480),
    'tablet 800x1280': Size(800, 1280),
  };

  Future<void> pump(
    WidgetTester tester,
    Size size,
    Widget page, {
    double textScale = 1,
    double keyboard = 0,
  }) async {
    await setUpTestDependencies();
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(
          size: size,
          textScaler: TextScaler.linear(textScale),
          viewInsets: EdgeInsets.only(bottom: keyboard),
        ),
        child: testApp(page),
      ),
    );
    await settle(tester);
  }

  final pages = <String, Widget Function()>{
    'register': () => RegisterPage(onGoToLogin: () {}),
    'login': () => LoginPage(onGoToRegister: () {}),
    'define focus': () => const DefineFocusPage(),
    'onboarding': () =>
        OnboardingPage(onSkip: () {}, onFinish: () {}, onLogin: () {}),
  };

  for (final page in pages.entries) {
    for (final size in sizes.entries) {
      for (final scale in [1.0, 1.6]) {
        testWidgets('${page.key} @ ${size.key} x$scale has no overflow', (
          tester,
        ) async {
          await pump(tester, size.value, page.value(), textScale: scale);
          expect(tester.takeException(), isNull);
        });
      }
    }
    testWidgets('${page.key} with keyboard open has no overflow', (
      tester,
    ) async {
      await pump(tester, const Size(411, 780), page.value(), keyboard: 300);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
    'register: last element reachable by scrolling on a short screen',
    (tester) async {
      await pump(
        tester,
        const Size(360, 560),
        RegisterPage(onGoToLogin: () {}),
      );
      await tester.scrollUntilVisible(
        find.text('v1.0'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('v1.0'), findsOneWidget);
    },
  );

  for (final size in sizes.entries) {
    for (final scale in [1.0, 1.6]) {
      testWidgets('tabs @ ${size.key} x$scale have no overflow', (
        tester,
      ) async {
        await setUpTestDependencies(
          signedInUser: testUser,
          focus: [
            for (var d = 1; d <= 30; d++)
              focusOn(
                DateTime(2024, 10, d),
                'Revisão do código do checkout muito longa $d',
              ),
          ],
        );
        tester.view.physicalSize = size.value;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(
              size: size.value,
              textScaler: TextScaler.linear(scale),
            ),
            child: const OneTickApp(showLocalModeStrip: false),
          ),
        );
        await settle(tester);
        expect(tester.takeException(), isNull, reason: 'today');
        for (final tab in ['Histórico', 'Configurações', 'Hoje']) {
          await tester.tap(find.text(tab).last);
          await settle(tester);
          expect(tester.takeException(), isNull, reason: tab);
        }
      });
    }
  }
}
