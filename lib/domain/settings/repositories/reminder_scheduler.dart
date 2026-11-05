/// Schedules the local daily reminder on the device.
abstract interface class ReminderScheduler {
  /// Asks the OS for notification permission; false when it is denied.
  Future<bool> requestPermission();

  /// Repeats every day at [hour]:[minute] (device time zone).
  Future<void> scheduleDaily({required int hour, required int minute});

  Future<void> cancel();
}
