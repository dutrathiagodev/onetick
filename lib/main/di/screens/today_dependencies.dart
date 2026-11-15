import '../../../core/utils/app_clock.dart';
import '../../../data/today/repositories/focus_repository_impl.dart';
import '../../../domain/today/repositories/focus_repository.dart';
import '../../../domain/today/usecases/complete_today_focus_use_case.dart';
import '../../../domain/today/usecases/get_streak_use_case.dart';
import '../../../domain/today/usecases/uncomplete_today_focus_use_case.dart';
import '../../../domain/today/usecases/get_today_focus_use_case.dart';
import '../../../infra/adapters/today/firestore_focus_adapter.dart';
import '../../../infra/adapters/today/focus_remote_adapter.dart';
import '../../../infra/adapters/today/in_memory_focus_adapter.dart';
import '../../../presenter/today/today_cubit.dart';
import '../service_locator.dart';
import 'login_dependencies.dart';

/// The focus adapter is shared by the today, define-focus, history and
/// settings screens, so `today` (owner of the focus domain) registers it.
void setupFocusAdapterDependencies() {
  setupLoginDependencies();
  if (!getIt.isRegistered<FocusRemoteAdapter>()) {
    getIt.registerLazySingleton<FocusRemoteAdapter>(
      () => getIt<AppConfig>().useFirebase
          ? FirestoreFocusAdapter(uidProvider: currentUserId)
          : InMemoryFocusAdapter(),
    );
  }
}

void setupTodayDependencies() {
  setupFocusAdapterDependencies();
  if (!getIt.isRegistered<FocusRepository>()) {
    getIt.registerLazySingleton<FocusRepository>(
      () => FocusRepositoryImpl(
        getIt<FocusRemoteAdapter>(),
        getIt<AppClock>().now,
      ),
    );
  }
  if (!getIt.isRegistered<GetTodayFocusUseCase>()) {
    getIt.registerFactory(() => GetTodayFocusUseCase(getIt<FocusRepository>()));
    getIt.registerFactory(
      () => CompleteTodayFocusUseCase(getIt<FocusRepository>()),
    );
    getIt.registerFactory(
      () => UncompleteTodayFocusUseCase(getIt<FocusRepository>()),
    );
    getIt.registerFactory(
      () => GetStreakUseCase(getIt<FocusRepository>(), getIt<AppClock>().now),
    );
  }
  if (!getIt.isRegistered<TodayCubit>()) {
    getIt.registerFactory(
      () => TodayCubit(
        getIt<GetTodayFocusUseCase>(),
        getIt<CompleteTodayFocusUseCase>(),
        getIt<UncompleteTodayFocusUseCase>(),
        getIt<GetStreakUseCase>(),
        getIt<AppClock>(),
      ),
    );
  }
}
