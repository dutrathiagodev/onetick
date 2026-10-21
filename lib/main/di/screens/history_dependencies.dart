import '../../../core/utils/app_clock.dart';
import '../../../data/history/repositories/history_repository_impl.dart';
import '../../../domain/history/repositories/history_repository.dart';
import '../../../domain/history/usecases/get_history_overview_use_case.dart';
import '../../../infra/adapters/focus/focus_remote_adapter.dart';
import '../../../presenter/history/history_cubit.dart';
import '../service_locator.dart';
import 'focus_adapter_dependencies.dart';

void setupHistoryDependencies() {
  setupFocusAdapterDependencies();
  if (!getIt.isRegistered<HistoryRepository>()) {
    getIt.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(getIt<FocusRemoteAdapter>()),
    );
  }
  if (!getIt.isRegistered<GetHistoryOverviewUseCase>()) {
    getIt.registerFactory(
      () => GetHistoryOverviewUseCase(
        getIt<HistoryRepository>(),
        getIt<AppClock>().now,
      ),
    );
  }
  if (!getIt.isRegistered<HistoryCubit>()) {
    getIt.registerFactory(
      () => HistoryCubit(
        getIt<GetHistoryOverviewUseCase>(),
        getIt<AppClock>().now,
      ),
    );
  }
}
