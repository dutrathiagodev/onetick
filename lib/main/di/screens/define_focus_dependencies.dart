import '../../../domain/focus/usecases/get_today_focus_use_case.dart';
import '../../../domain/focus/usecases/save_today_focus_use_case.dart';
import '../../../domain/focus/repositories/focus_repository.dart';
import '../../../presenter/define_focus/define_focus_cubit.dart';
import '../service_locator.dart';
import 'today_dependencies.dart';

void setupDefineFocusDependencies() {
  setupTodayDependencies();
  if (!getIt.isRegistered<SaveTodayFocusUseCase>()) {
    getIt.registerFactory(
      () => SaveTodayFocusUseCase(getIt<FocusRepository>()),
    );
  }
  if (!getIt.isRegistered<DefineFocusCubit>()) {
    getIt.registerFactory(
      () => DefineFocusCubit(
        getIt<GetTodayFocusUseCase>(),
        getIt<SaveTodayFocusUseCase>(),
      ),
    );
  }
}
