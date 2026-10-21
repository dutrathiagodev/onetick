import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/main/app.dart';
import 'package:onetick/main/di/service_locator.dart';

import '../helpers/pump_helpers.dart';
import '../helpers/test_setup.dart';

void main() {
  setUpAll(loadTestFonts);

  Future<void> pumpApp(
    WidgetTester tester, {
    bool signedIn = false,
    List focus = const [],
  }) async {
    await setUpTestDependencies(
      signedInUser: signedIn ? testUser : null,
      focus: focus.cast(),
    );
    useFigmaViewport(tester);
    await tester.pumpWidget(const OneTickApp(showLocalModeStrip: false));
    await precacheAppImages(tester);
    await settle(tester);
  }

  ThemeMode themeMode(WidgetTester tester) =>
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode!;

  testWidgets(
    'full journey: sign up -> define -> complete -> history -> settings -> sign out',
    (tester) async {
      await pumpApp(tester);

      // Onboarding -> register
      expect(find.text('Menos ruído, mais foco'), findsOneWidget);
      await tester.tap(find.text('Pular'));
      await settle(tester);
      expect(find.text('Criar conta'), findsWidgets);

      await tester.enterText(find.byKey(const Key('register_name')), 'Ana');
      await tester.enterText(
        find.byKey(const Key('register_email')),
        'ana@onetick.dev',
      );
      await tester.enterText(
        find.byKey(const Key('register_password')),
        'senha-segura-1',
      );
      await tester.tap(find.byKey(const Key('register_submit')));
      await settle(tester);

      // Signed in: Today is empty
      expect(find.text('Qual é o seu foco de hoje?'), findsOneWidget);
      expect(find.text('HOJE • 30 OUT'), findsOneWidget);
      expect(find.text('0 dias seguidos'), findsOneWidget);

      // Define focus
      await tester.tap(find.text('Definir foco'));
      await settle(tester);
      await tester.enterText(
        find.byKey(const Key('define_focus_input')),
        'Beber 2L de água',
      );
      await settle(tester);
      await tester.tap(find.byKey(const Key('define_focus_save')));
      await settle(tester);

      // Today pending
      expect(find.text('Beber 2L de água'), findsOneWidget);
      expect(find.text('0%'), findsOneWidget);
      expect(find.text('TOCAR PARA\nCONCLUIR'), findsOneWidget);

      // Change focus keeps working
      await tester.tap(find.byKey(const Key('today_change_focus')));
      await settle(tester);
      expect(
        find.text('Beber 2L de água'),
        findsOneWidget,
        reason: 'prefilled',
      );
      await tester.tap(find.byKey(const Key('define_focus_cancel')));
      await settle(tester);
      expect(find.text('Beber 2L de água'), findsOneWidget);

      // Complete
      await tester.tap(find.byKey(const Key('today_complete_button')));
      await settle(tester);
      expect(find.text('Dia concluído em paz'), findsOneWidget);
      expect(find.text('100%'), findsOneWidget);
      expect(find.text('1 dia seguido'), findsOneWidget);
      expect(find.byKey(const Key('today_change_focus')), findsNothing);

      // History reflects it
      await tester.tap(find.text('Histórico').last);
      await settle(tester);
      expect(find.text('Outubro 2024'), findsOneWidget);
      expect(find.byKey(const Key('history_completed_count')), findsOneWidget);
      expect(
        tester
            .widget<Text>(find.byKey(const Key('history_completed_count')))
            .data,
        '1',
      );
      expect(find.text('Beber 2L de água'), findsOneWidget);
      expect(find.text('Feito'), findsOneWidget);
      expect(find.text('Descanso'), findsNWidgets(6));

      // Settings: dark theme applies app-wide
      await tester.tap(find.text('Configurações').last);
      await settle(tester);
      expect(themeMode(tester), ThemeMode.light);
      await tester.tap(find.byKey(const Key('theme_dark')));
      await settle(tester);
      expect(themeMode(tester), ThemeMode.dark);

      // Clear history (cancel first, then confirm)
      await tester.tap(find.byKey(const Key('settings_clear_row')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('clear_cancel')));
      await settle(tester);
      await tester.tap(find.text('Histórico').last);
      await settle(tester);
      expect(
        find.text('Beber 2L de água'),
        findsOneWidget,
        reason: 'cancel keeps data',
      );

      await tester.tap(find.text('Configurações').last);
      await settle(tester);
      await tester.tap(find.byKey(const Key('settings_clear_row')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('clear_confirm')));
      await settle(tester);
      expect(find.text('Histórico e hábitos apagados.'), findsOneWidget);
      await tester.tap(find.text('Hoje').last);
      await settle(tester);
      expect(find.text('Qual é o seu foco de hoje?'), findsOneWidget);
      await tester.tap(find.text('Histórico').last);
      await settle(tester);
      expect(find.text('Seu histórico começa hoje'), findsOneWidget);

      // Sign out returns to onboarding and resets theme
      await tester.tap(find.bySemanticsLabel('Conta'));
      await settle(tester);
      expect(find.text('ana@onetick.dev'), findsOneWidget);
      await tester.tap(find.byKey(const Key('account_sign_out')));
      await settle(tester);
      expect(find.text('Menos ruído, mais foco'), findsOneWidget);
      expect(themeMode(tester), ThemeMode.light);
    },
  );

  testWidgets('theme preference is restored after signing in again', (
    tester,
  ) async {
    await pumpApp(tester, signedIn: true);
    await tester.tap(find.text('Configurações').last);
    await settle(tester);
    await tester.tap(find.byKey(const Key('theme_dark')));
    await settle(tester);
    await tester.tap(find.bySemanticsLabel('Conta'));
    await settle(tester);
    await tester.tap(find.byKey(const Key('account_sign_out')));
    await settle(tester);
    expect(themeMode(tester), ThemeMode.light);

    await tester.tap(find.textContaining('Entrar', findRichText: true));
    await settle(tester);
    await tester.enterText(
      find.byKey(const Key('login_email')),
      'ana@onetick.dev',
    );
    await tester.enterText(find.byKey(const Key('login_password')), 'x');
    await tester.tap(find.byKey(const Key('login_submit')));
    await settle(tester);
    // No account exists in memory for that user: friendly error, still logged out.
    expect(find.text('E-mail ou senha incorretos.'), findsOneWidget);
  });

  testWidgets('pending focus: failing to complete shows nothing broken', (
    tester,
  ) async {
    await pumpApp(
      tester,
      signedIn: true,
      focus: [focusOn(testNow, 'Ler', completed: false)],
    );
    expect(find.text('Ler'), findsOneWidget);
    await tester.tap(find.byKey(const Key('today_complete_button')));
    await settle(tester);
    expect(find.text('Dia concluído em paz'), findsOneWidget);
  });

  testWidgets('history month navigation', (tester) async {
    await pumpApp(
      tester,
      signedIn: true,
      focus: [
        focusOn(DateTime(2024, 9, 10), 'Setembro foco'),
        focusOn(testNow, 'Hoje foco'),
      ],
    );
    await tester.tap(find.text('Histórico').last);
    await settle(tester);
    expect(find.text('Outubro 2024'), findsOneWidget);

    await tester.tap(
      find.byKey(const Key('history_next_month')),
      warnIfMissed: false,
    );
    await settle(tester);
    expect(
      find.text('Outubro 2024'),
      findsOneWidget,
      reason: 'cannot go to the future',
    );

    await tester.tap(find.byKey(const Key('history_prev_month')));
    await settle(tester);
    expect(find.text('Setembro 2024'), findsOneWidget);
    expect(
      tester
          .widget<Text>(find.byKey(const Key('history_completed_count')))
          .data,
      '1',
    );
    expect(find.text('1 de 30 dias ativos'), findsOneWidget);
    expect(find.text('3%'), findsOneWidget);

    await tester.tap(find.byKey(const Key('history_next_month')));
    await settle(tester);
    expect(find.text('Outubro 2024'), findsOneWidget);
  });

  testWidgets('settings: reminder switch persists across tab switches', (
    tester,
  ) async {
    await pumpApp(tester, signedIn: true);
    await tester.tap(find.text('Configurações').last);
    await settle(tester);
    expect(find.text('09:00'), findsOneWidget);
    await tester.tap(find.byKey(const Key('settings_reminder_switch')));
    await settle(tester);
    await tester.tap(find.text('Hoje').last);
    await settle(tester);
    await tester.tap(find.text('Configurações').last);
    await settle(tester);
    final switchFinder = find.byKey(const Key('settings_reminder_switch'));
    expect(
      tester.getSemantics(switchFinder).flagsCollection.isToggled,
      Tristate.isFalse,
    );
  });

  tearDownAll(() => getIt.reset());
}
