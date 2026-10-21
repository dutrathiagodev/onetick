import '../../../core/failures.dart';
import '../../../data/auth/repositories/auth_repository_impl.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../../../domain/auth/usecases/send_password_reset_use_case.dart';
import '../../../domain/auth/usecases/sign_in_use_case.dart';
import '../../../domain/auth/usecases/sign_in_with_google_use_case.dart';
import '../../../domain/auth/usecases/sign_out_use_case.dart';
import '../../../domain/auth/usecases/sign_up_use_case.dart';
import '../../../domain/auth/usecases/watch_auth_state_use_case.dart';
import '../../../infra/adapters/auth/auth_remote_adapter.dart';
import '../../../infra/adapters/auth/firebase_auth_adapter.dart';
import '../../../infra/adapters/auth/in_memory_auth_adapter.dart';
import '../../../presenter/login/login_cubit.dart';
import '../../../presenter/register/register_cubit.dart';
import '../../../presenter/session/session_cubit.dart';
import '../service_locator.dart';

/// Used by the other feature DIs to scope data to the signed in user.
String currentUserId() {
  final user = getIt<AuthRepository>().currentUser;
  if (user == null) {
    throw const AppFailure('Sua sessão expirou. Entre novamente.');
  }
  return user.id;
}

void setupAuthDependencies() {
  if (!getIt.isRegistered<AuthRemoteAdapter>()) {
    getIt.registerLazySingleton<AuthRemoteAdapter>(
      () => getIt<AppConfig>().useFirebase
          ? FirebaseAuthAdapter()
          : InMemoryAuthAdapter(),
    );
  }
  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthRemoteAdapter>()),
    );
  }
  if (!getIt.isRegistered<SignInUseCase>()) {
    getIt.registerFactory(() => SignInUseCase(getIt<AuthRepository>()));
    getIt.registerFactory(() => SignUpUseCase(getIt<AuthRepository>()));
    getIt.registerFactory(
      () => SignInWithGoogleUseCase(getIt<AuthRepository>()),
    );
    getIt.registerFactory(() => SignOutUseCase(getIt<AuthRepository>()));
    getIt.registerFactory(
      () => SendPasswordResetUseCase(getIt<AuthRepository>()),
    );
    getIt.registerFactory(() => WatchAuthStateUseCase(getIt<AuthRepository>()));
  }
  if (!getIt.isRegistered<SessionCubit>()) {
    getIt.registerLazySingleton(
      () =>
          SessionCubit(getIt<WatchAuthStateUseCase>(), getIt<SignOutUseCase>()),
    );
  }
  if (!getIt.isRegistered<LoginCubit>()) {
    getIt.registerFactory(
      () => LoginCubit(
        getIt<SignInUseCase>(),
        getIt<SignInWithGoogleUseCase>(),
        getIt<SendPasswordResetUseCase>(),
      ),
    );
  }
  if (!getIt.isRegistered<RegisterCubit>()) {
    getIt.registerFactory(
      () => RegisterCubit(
        getIt<SignUpUseCase>(),
        getIt<SignInWithGoogleUseCase>(),
      ),
    );
  }
}
