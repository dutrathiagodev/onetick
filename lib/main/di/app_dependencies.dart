import '../../core/utils/app_clock.dart';
import 'screens/auth_dependencies.dart';
import 'screens/define_focus_dependencies.dart';
import 'screens/history_dependencies.dart';
import 'screens/onboarding_dependencies.dart';
import 'screens/settings_dependencies.dart';
import 'screens/today_dependencies.dart';
import 'service_locator.dart';

/// Registers the global graph. Each screen also calls its own `setup*` (all
/// idempotent), so tests may pre-register fakes before pumping a page.
void setupAppDependencies({
  required bool useFirebase,
  AppClock clock = const AppClock(),
}) {
  if (!getIt.isRegistered<AppConfig>()) {
    getIt.registerSingleton<AppConfig>(AppConfig(useFirebase: useFirebase));
  }
  if (!getIt.isRegistered<AppClock>()) {
    getIt.registerSingleton<AppClock>(clock);
  }
  setupAuthDependencies();
  setupOnboardingDependencies();
  setupTodayDependencies();
  setupDefineFocusDependencies();
  setupHistoryDependencies();
  setupSettingsDependencies();
}

Future<void> resetAppDependencies() => getIt.reset();
