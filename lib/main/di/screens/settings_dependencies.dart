import '../../../data/settings/repositories/settings_repository_impl.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../../../domain/settings/repositories/reminder_scheduler.dart';
import '../../../domain/settings/repositories/settings_repository.dart';
import '../../../domain/settings/usecases/clear_history_use_case.dart';
import '../../../domain/settings/usecases/delete_account_use_case.dart';
import '../../../domain/settings/usecases/get_settings_use_case.dart';
import '../../../domain/settings/usecases/save_settings_use_case.dart';
import '../../../domain/settings/usecases/sync_reminder_use_case.dart';
import '../../../infra/adapters/focus/focus_remote_adapter.dart';
import '../../../infra/adapters/notifications/local_reminder_scheduler.dart';
import '../../../infra/adapters/settings/firestore_settings_adapter.dart';
import '../../../infra/adapters/settings/in_memory_settings_adapter.dart';
import '../../../infra/adapters/settings/settings_remote_adapter.dart';
import '../../../presenter/settings/app_theme_cubit.dart';
import '../../../presenter/settings/settings_cubit.dart';
import '../service_locator.dart';
import 'auth_dependencies.dart';
import 'focus_adapter_dependencies.dart';

void setupSettingsDependencies() {
  setupFocusAdapterDependencies();
  if (!getIt.isRegistered<SettingsRemoteAdapter>()) {
    getIt.registerLazySingleton<SettingsRemoteAdapter>(
      () => getIt<AppConfig>().useFirebase
          ? FirestoreSettingsAdapter(uidProvider: currentUserId)
          : InMemorySettingsAdapter(),
    );
  }
  if (!getIt.isRegistered<SettingsRepository>()) {
    getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        getIt<SettingsRemoteAdapter>(),
        getIt<FocusRemoteAdapter>(),
      ),
    );
  }
  if (!getIt.isRegistered<ReminderScheduler>()) {
    getIt.registerLazySingleton<ReminderScheduler>(LocalReminderScheduler.new);
  }
  if (!getIt.isRegistered<SyncReminderUseCase>()) {
    getIt.registerFactory(
      () => SyncReminderUseCase(
        getIt<ReminderScheduler>(),
        getIt<SettingsRepository>(),
      ),
    );
  }
  if (!getIt.isRegistered<DeleteAccountUseCase>()) {
    getIt.registerFactory(
      () => DeleteAccountUseCase(
        getIt<AuthRepository>(),
        getIt<SettingsRepository>(),
      ),
    );
  }
  if (!getIt.isRegistered<GetSettingsUseCase>()) {
    getIt.registerFactory(
      () => GetSettingsUseCase(getIt<SettingsRepository>()),
    );
    getIt.registerFactory(
      () => SaveSettingsUseCase(getIt<SettingsRepository>()),
    );
    getIt.registerFactory(
      () => ClearHistoryUseCase(getIt<SettingsRepository>()),
    );
  }
  if (!getIt.isRegistered<AppThemeCubit>()) {
    getIt.registerLazySingleton(
      () => AppThemeCubit(getIt<GetSettingsUseCase>()),
    );
  }
  if (!getIt.isRegistered<SettingsCubit>()) {
    getIt.registerFactory(
      () => SettingsCubit(
        getIt<GetSettingsUseCase>(),
        getIt<SaveSettingsUseCase>(),
        getIt<ClearHistoryUseCase>(),
        getIt<AppThemeCubit>(),
        getIt<SyncReminderUseCase>(),
        getIt<DeleteAccountUseCase>(),
      ),
    );
  }
}
