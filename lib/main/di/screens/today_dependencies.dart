import '../../../core/utils/app_clock.dart';
import '../../../data/focus/repositories/focus_repository_impl.dart';
import '../../../domain/focus/repositories/focus_repository.dart';
import '../../../domain/focus/usecases/complete_today_focus_use_case.dart';
import '../../../domain/focus/usecases/get_streak_use_case.dart';
import '../../../domain/focus/usecases/uncomplete_today_focus_use_case.dart';
import '../../../domain/focus/usecases/get_today_focus_use_case.dart';
import '../../../infra/adapters/focus/focus_remote_adapter.dart';
import '../../../presenter/today/today_cubit.dart';
import '../service_locator.dart';
import 'focus_adapter_dependencies.dart';

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
      ),
    );
  }
}
