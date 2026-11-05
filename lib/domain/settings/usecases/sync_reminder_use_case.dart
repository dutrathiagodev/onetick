import '../entities/app_settings.dart';
import '../repositories/reminder_scheduler.dart';
import '../repositories/settings_repository.dart';

/// Keeps the device's daily reminder in line with the saved preferences.
class SyncReminderUseCase {
  const SyncReminderUseCase(this._scheduler, this._settings);

  final ReminderScheduler _scheduler;
  final SettingsRepository _settings;

  /// Used on sign in: the reminder follows the user to a new device.
  Future<bool> restore() async => call(await _settings.load());

  /// Schedules (or cancels) the reminder. Returns false when it is enabled but
  /// the OS denied notifications, so nothing will be shown.
  Future<bool> call(AppSettings settings) async {
    if (!settings.reminderEnabled) {
      await _scheduler.cancel();
      return true;
    }
    if (!await _scheduler.requestPermission()) return false;
    await _scheduler.scheduleDaily(
      hour: settings.reminderHour,
      minute: settings.reminderMinute,
    );
    return true;
  }

  /// Used on sign out: the next user has their own preferences.
  Future<void> cancel() => _scheduler.cancel();
}
