import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../../domain/settings/repositories/reminder_scheduler.dart';

/// Daily reminder as a local notification with the OneTick mark.
class LocalReminderScheduler implements ReminderScheduler {
  LocalReminderScheduler({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _init;

  static const _id = 1;
  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'daily_reminder',
      'Lembrete diário',
      channelDescription: 'Lembrete para definir e concluir o foco do dia.',
      icon: 'ic_stat_onetick',
      color: Color(0xFF0468D7),
    ),
    iOS: DarwinNotificationDetails(),
  );

  Future<void> _ensureInit() => _init ??= () async {
    tz_data.initializeTimeZones();
    final zone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(zone.identifier));
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_onetick'),
        // Permission is asked from Settings, not at launch.
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
  }();

  @override
  Future<bool> requestPermission() async {
    await _ensureInit();
    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return await android?.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    return await ios?.requestPermissions(alert: true, sound: true) ?? false;
  }

  @override
  Future<void> scheduleDaily({required int hour, required int minute}) async {
    await _ensureInit();
    await _plugin.zonedSchedule(
      id: _id,
      title: 'Qual é o seu foco de hoje?',
      body: 'Um único compromisso essencial. Toque para abrir o OneTick.',
      scheduledDate: _nextInstance(hour, minute),
      notificationDetails: _details,
      androidScheduleMode: await _scheduleMode(),
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> cancel() async {
    await _ensureInit();
    await _plugin.cancel(id: _id);
  }

  /// Exact when "Alarms & reminders" is allowed; otherwise Android may deliver
  /// it up to an hour late, which is still better than no reminder.
  Future<AndroidScheduleMode> _scheduleMode() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final exact = await android?.canScheduleExactNotifications() ?? false;
    return exact
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }

  tz.TZDateTime _nextInstance(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var at = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!at.isAfter(now)) at = at.add(const Duration(days: 1));
    return at;
  }
}
