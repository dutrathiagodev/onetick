import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/core/theme/app_theme.dart';
import 'package:onetick/core/utils/app_clock.dart';
import 'package:onetick/data/auth/models/auth_user_model.dart';
import 'package:onetick/data/focus/models/focus_model.dart';
import 'package:onetick/infra/adapters/auth/auth_remote_adapter.dart';
import 'package:onetick/infra/adapters/auth/in_memory_auth_adapter.dart';
import 'package:onetick/infra/adapters/focus/focus_remote_adapter.dart';
import 'package:onetick/infra/adapters/focus/in_memory_focus_adapter.dart';
import 'package:onetick/main/di/app_dependencies.dart';
import 'package:onetick/main/di/service_locator.dart';

/// Fixed "now" used by every test: Wednesday, 30 Oct 2024, 14:30.
final DateTime testNow = DateTime(2024, 10, 30, 14, 30);

class FixedClock extends AppClock {
  const FixedClock(this.value);

  final DateTime value;

  @override
  DateTime now() => value;
}

const testUser = AuthUserModel(
  id: 'user-1',
  email: 'ana@onetick.dev',
  name: 'Ana',
);

/// Rebuilds the DI graph with in-memory adapters (no Firebase).
Future<InMemoryFocusAdapter> setUpTestDependencies({
  DateTime? now,
  AuthUserModel? signedInUser,
  Iterable<FocusModel> focus = const [],
}) async {
  await getIt.reset();
  final focusAdapter = InMemoryFocusAdapter(focus);
  getIt.registerSingleton<AuthRemoteAdapter>(
    InMemoryAuthAdapter(initialUser: signedInUser),
  );
  getIt.registerSingleton<FocusRemoteAdapter>(focusAdapter);
  setupAppDependencies(useFirebase: false, clock: FixedClock(now ?? testNow));
  return focusAdapter;
}

FocusModel focusOn(DateTime date, String title, {bool completed = true}) {
  final key =
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  return FocusModel(
    dateKey: key,
    title: title,
    completed: completed,
    completedAt: completed
        ? DateTime(date.year, date.month, date.day, 18, 5)
        : null,
  );
}

/// Phone-sized surface matching the Figma frames (440x890).
void useFigmaViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(440, 890);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Widget testApp(Widget home, {ThemeMode mode = ThemeMode.light}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: mode,
    home: home,
  );
}
