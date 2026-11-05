import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/domain/settings/entities/app_settings.dart';
import 'package:onetick/domain/settings/repositories/reminder_scheduler.dart';
import 'package:onetick/domain/settings/repositories/settings_repository.dart';
import 'package:onetick/domain/settings/usecases/sync_reminder_use_case.dart';
import 'package:onetick/infra/adapters/notifications/in_memory_reminder_scheduler.dart';
import 'package:onetick/main/di/service_locator.dart';
import 'package:onetick/presenter/settings/settings_cubit.dart';
import 'package:onetick/presenter/settings/settings_state.dart';

import '../helpers/test_setup.dart';

void main() {
  late InMemoryReminderScheduler scheduler;

  setUp(() async {
    await setUpTestDependencies(signedInUser: testUser);
    scheduler = getIt<ReminderScheduler>() as InMemoryReminderScheduler;
  });

  Future<SettingsCubit> loadedCubit() async {
    final cubit = getIt<SettingsCubit>();
    await cubit.load();
    return cubit;
  }

  AppSettings settingsOf(SettingsCubit cubit) =>
      (cubit.state as SettingsLoaded).settings;

  group('SyncReminderUseCase', () {
    test('restore schedules the saved time', () async {
      await getIt<SettingsRepository>().save(
        const AppSettings(reminderHour: 20, reminderMinute: 15),
      );
      expect(await getIt<SyncReminderUseCase>().restore(), isTrue);
      expect(scheduler.scheduled, (20, 15));
    });

    test('disabled reminder cancels the notification', () async {
      scheduler.scheduled = (9, 0);
      await getIt<SyncReminderUseCase>()(
        const AppSettings(reminderEnabled: false),
      );
      expect(scheduler.scheduled, isNull);
    });

    test('denied permission schedules nothing', () async {
      scheduler.permissionGranted = false;
      expect(await getIt<SyncReminderUseCase>()(const AppSettings()), isFalse);
      expect(scheduler.scheduled, isNull);
    });
  });

  group('SettingsCubit reminder', () {
    test('changing the time reschedules and saves', () async {
      final cubit = await loadedCubit();
      await cubit.setReminderTime(7, 30);

      expect(scheduler.scheduled, (7, 30));
      expect(settingsOf(cubit).reminderLabel, '07:30');
      expect((await getIt<SettingsRepository>().load()).reminderHour, 7);
    });

    test('turning it off cancels the notification', () async {
      scheduler.scheduled = (9, 0);
      final cubit = await loadedCubit();
      await cubit.setReminderEnabled(false);

      expect(scheduler.scheduled, isNull);
      expect(settingsOf(cubit).reminderEnabled, isFalse);
    });

    test('denied permission keeps the switch off and explains why', () async {
      await getIt<SettingsRepository>().save(
        const AppSettings(reminderEnabled: false),
      );
      scheduler.permissionGranted = false;
      final cubit = await loadedCubit();
      await cubit.setReminderEnabled(true);

      final state = cubit.state as SettingsLoaded;
      expect(state.settings.reminderEnabled, isFalse);
      expect(state.notice, contains('Permita as notificações'));
      expect(scheduler.scheduled, isNull);
    });
  });
}
