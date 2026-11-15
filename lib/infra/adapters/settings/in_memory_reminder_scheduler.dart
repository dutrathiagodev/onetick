import '../../../domain/settings/repositories/reminder_scheduler.dart';

/// Test double: records the scheduled time instead of notifying.
class InMemoryReminderScheduler implements ReminderScheduler {
  InMemoryReminderScheduler({this.permissionGranted = true});

  bool permissionGranted;

  /// `(hour, minute)` of the active reminder, or null when none is scheduled.
  (int, int)? scheduled;

  @override
  Future<bool> requestPermission() async => permissionGranted;

  @override
  Future<void> scheduleDaily({required int hour, required int minute}) async =>
      scheduled = (hour, minute);

  @override
  Future<void> cancel() async => scheduled = null;
}
