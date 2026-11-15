import '../../../domain/login/usecases/sign_out_use_case.dart';
import '../../../domain/login/usecases/watch_auth_state_use_case.dart';
import '../../../presenter/session/session_cubit.dart';
import '../service_locator.dart';
import 'login_dependencies.dart';

void setupSessionDependencies() {
  setupLoginDependencies();
  if (!getIt.isRegistered<SessionCubit>()) {
    getIt.registerLazySingleton(
      () =>
          SessionCubit(getIt<WatchAuthStateUseCase>(), getIt<SignOutUseCase>()),
    );
  }
}
