import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/core/widgets/feedback.dart';
import 'package:onetick/core/widgets/reminder_time_picker.dart';
import 'package:onetick/modules/settings/widgets/pill_switch.dart';

import '../helpers/test_setup.dart';

/// On iOS the app swaps three custom/Material pieces for native ones;
/// Android keeps the design from Stitch.
void main() {
  /// Runs [body] as iOS and always restores the platform (the test binding
  /// fails a test that leaves the override set).
  Future<void> onIos(Future<void> Function() body) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await body();
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  }

  testWidgets('switch: pill on Android, CupertinoSwitch on iOS', (
    tester,
  ) async {
    Widget app() => testApp(
      PillSwitch(value: true, onChanged: (_) {}, semanticsLabel: 'Lembrete'),
    );

    await tester.pumpWidget(app());
    expect(find.byType(CupertinoSwitch), findsNothing);

    await onIos(() async {
      await tester.pumpWidget(app());
      expect(find.byType(CupertinoSwitch), findsOneWidget);
    });
  });

  testWidgets('danger confirm: Material on Android, Cupertino on iOS', (
    tester,
  ) async {
    Future<void> open(WidgetTester t, void Function(bool?) onResult) async {
      await t.pumpWidget(
        testApp(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async => onResult(
                await showDangerConfirm(
                  context,
                  title: 'Excluir',
                  message: 'Tem certeza?',
                  action: 'Excluir',
                  keyPrefix: 'del',
                ),
              ),
              child: const Text('abrir'),
            ),
          ),
        ),
      );
      await t.tap(find.text('abrir'));
      await t.pumpAndSettle();
    }

    await open(tester, (_) {});
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CupertinoAlertDialog), findsNothing);
    await tester.tap(find.byKey(const Key('del_cancel')));
    await tester.pumpAndSettle();

    await onIos(() async {
      bool? result;
      await open(tester, (r) => result = r);
      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
      await tester.tap(find.byKey(const Key('del_confirm')));
      await tester.pumpAndSettle();
      expect(result, true);
    });
  });

  testWidgets('time picker on iOS is a wheel that returns the chosen time', (
    tester,
  ) async {
    await onIos(() async {
      TimeOfDay? picked;
      await tester.pumpWidget(
        testApp(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async => picked = await pickTimeOfDay(
                context,
                initial: const TimeOfDay(hour: 9, minute: 0),
                title: 'Horário preferido',
              ),
              child: const Text('abrir'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
      expect(find.byType(TimePickerDialog), findsNothing);

      await tester.tap(find.byKey(const Key('time_confirm')));
      await tester.pumpAndSettle();
      expect(picked, const TimeOfDay(hour: 9, minute: 0));
    });
  });
}
