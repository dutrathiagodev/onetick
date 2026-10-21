import 'package:flutter/material.dart';

import 'dart:ui' show CheckedState;

import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/modules/login/page/login_page.dart';
import 'package:onetick/modules/register/page/register_page.dart';

import '../helpers/pump_helpers.dart';
import '../helpers/test_setup.dart';

void main() {
  setUpAll(loadTestFonts);

  group('LoginPage', () {
    var wentToRegister = false;

    Future<void> pumpLogin(WidgetTester tester) async {
      wentToRegister = false;
      await setUpTestDependencies();
      useFigmaViewport(tester);
      await tester.pumpWidget(
        testApp(LoginPage(onGoToRegister: () => wentToRegister = true)),
      );
      await settle(tester);
    }

    testWidgets('validates empty and malformed e-mail', (tester) async {
      await pumpLogin(tester);
      await tester.tap(find.byKey(const Key('login_submit')));
      await settle(tester);
      expect(find.text('Informe seu e-mail.'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('login_email')), 'abc');
      await settle(tester);
      expect(
        find.text('Informe seu e-mail.'),
        findsNothing,
        reason: 'typing clears the error',
      );
      await tester.tap(find.byKey(const Key('login_submit')));
      await settle(tester);
      expect(find.text('Digite um e-mail válido.'), findsOneWidget);
    });

    testWidgets('requires a password and rejects unknown credentials', (
      tester,
    ) async {
      await pumpLogin(tester);
      await tester.enterText(
        find.byKey(const Key('login_email')),
        'ana@onetick.dev',
      );
      await tester.tap(find.byKey(const Key('login_submit')));
      await settle(tester);
      expect(find.text('Informe sua senha.'), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key('login_password')),
        'segredo123',
      );
      await tester.tap(find.byKey(const Key('login_submit')));
      await settle(tester);
      expect(find.text('E-mail ou senha incorretos.'), findsOneWidget);
    });

    testWidgets('password visibility toggle works', (tester) async {
      await pumpLogin(tester);
      TextField field() => tester.widget<TextField>(
        find.descendant(
          of: find.byKey(const Key('login_password')),
          matching: find.byType(TextField),
        ),
      );
      expect(field().obscureText, isTrue);
      await tester.tap(find.bySemanticsLabel('Mostrar senha'));
      await settle(tester);
      expect(field().obscureText, isFalse);
    });

    testWidgets('forgot password asks for a valid e-mail, then confirms', (
      tester,
    ) async {
      await pumpLogin(tester);
      await tester.tap(find.byKey(const Key('login_forgot_password')));
      await settle(tester);
      expect(find.text('Informe seu e-mail.'), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key('login_email')),
        'ana@onetick.dev',
      );
      await tester.tap(find.byKey(const Key('login_forgot_password')));
      await settle(tester);
      expect(
        find.text('Enviamos um link de recuperação para o seu e-mail.'),
        findsOneWidget,
      );
    });

    testWidgets('link to sign-up', (tester) async {
      await pumpLogin(tester);
      await tester.tap(find.byKey(const Key('login_go_register')));
      expect(wentToRegister, isTrue);
    });
  });

  group('RegisterPage', () {
    Future<void> pumpRegister(WidgetTester tester) async {
      await setUpTestDependencies();
      useFigmaViewport(tester);
      await tester.pumpWidget(testApp(RegisterPage(onGoToLogin: () {})));
      await settle(tester);
    }

    testWidgets('validates name, e-mail and 8-char password in order', (
      tester,
    ) async {
      await pumpRegister(tester);
      await tester.tap(find.byKey(const Key('register_submit')));
      await settle(tester);
      expect(find.text('Informe como quer ser chamado.'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('register_name')), 'Ana');
      await tester.tap(find.byKey(const Key('register_submit')));
      await settle(tester);
      expect(find.text('Informe seu e-mail.'), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key('register_email')),
        'ana@onetick.dev',
      );
      await tester.enterText(
        find.byKey(const Key('register_password')),
        '1234567',
      );
      await tester.tap(find.byKey(const Key('register_submit')));
      await settle(tester);
      expect(
        find.text('A senha precisa ter no mínimo 8 caracteres.'),
        findsOneWidget,
      );
    });

    testWidgets('commitment check toggles', (tester) async {
      await pumpRegister(tester);
      final check = find.byKey(const Key('register_commitment'));
      expect(
        tester.getSemantics(check).flagsCollection.isChecked,
        CheckedState.isTrue,
      );
      await tester.tap(check);
      await settle(tester);
      expect(
        tester.getSemantics(check).flagsCollection.isChecked,
        CheckedState.isFalse,
      );
    });
  });
}
