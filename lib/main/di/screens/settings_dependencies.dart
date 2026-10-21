import '../../../data/settings/repositories/settings_repository_impl.dart';
import '../../../domain/settings/repositories/settings_repository.dart';
import '../../../domain/settings/usecases/clear_history_use_case.dart';
import '../../../domain/settings/usecases/get_settings_use_case.dart';
import '../../../domain/settings/usecases/save_settings_use_case.dart';
import '../../../infra/adapters/focus/focus_remote_adapter.dart';
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
      ),
    );
  }
}
