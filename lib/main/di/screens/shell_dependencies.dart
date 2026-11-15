import '../../../presenter/shell/shell_cubit.dart';
import '../service_locator.dart';

void setupShellDependencies() {
  if (!getIt.isRegistered<ShellCubit>()) {
    getIt.registerFactory(() => ShellCubit());
  }
}
