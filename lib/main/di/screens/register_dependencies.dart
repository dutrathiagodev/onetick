import '../../../domain/login/usecases/sign_in_with_google_use_case.dart';
import '../../../domain/login/usecases/sign_up_use_case.dart';
import '../../../presenter/register/register_cubit.dart';
import '../service_locator.dart';
import 'login_dependencies.dart';

void setupRegisterDependencies() {
  setupLoginDependencies();
  if (!getIt.isRegistered<RegisterCubit>()) {
    getIt.registerFactory(
      () => RegisterCubit(
        getIt<SignUpUseCase>(),
        getIt<SignInWithGoogleUseCase>(),
      ),
    );
  }
}
