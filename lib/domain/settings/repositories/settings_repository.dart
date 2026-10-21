import '../entities/app_settings.dart';

abstract interface class SettingsRepository {
  Future<AppSettings> load();

  Future<void> save(AppSettings settings);

  /// Removes every focus entry of the signed in user.
  Future<void> clearHistory();
}
