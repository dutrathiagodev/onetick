import 'package:flutter/foundation.dart';

import '../../../core/failures.dart';
import '../../../data/login/repositories/auth_repository_impl.dart';
import '../../../domain/login/repositories/auth_repository.dart';
import '../../../domain/login/usecases/send_password_reset_use_case.dart';
import '../../../domain/login/usecases/sign_in_use_case.dart';
import '../../../domain/login/usecases/sign_in_with_google_use_case.dart';
import '../../../domain/login/usecases/sign_out_use_case.dart';
import '../../../domain/login/usecases/sign_up_use_case.dart';
import '../../../domain/login/usecases/watch_auth_state_use_case.dart';
import '../../../infra/adapters/login/auth_remote_adapter.dart';
import '../../../infra/adapters/login/firebase_auth_adapter.dart';
import '../../../infra/adapters/login/in_memory_auth_adapter.dart';
import '../../../presenter/login/login_cubit.dart';
import '../../firebase_options.dart';
import '../service_locator.dart';

/// Used by the other feature DIs to scope data to the signed in user.
String currentUserId() {
  final user = getIt<AuthRepository>().currentUser;
  if (user == null) {
    throw const AppFailure('Sua sessão expirou. Entre novamente.');
  }
  return user.id;
}

/// Shared by login, register and session: adapter, repository and use cases.
void setupLoginDependencies() {
  if (!getIt.isRegistered<AuthRemoteAdapter>()) {
    getIt.registerLazySingleton<AuthRemoteAdapter>(
      () => getIt<AppConfig>().useFirebase
          ? FirebaseAuthAdapter(
              googleClientId: defaultTargetPlatform == TargetPlatform.iOS
                  ? DefaultFirebaseOptions.ios.iosClientId
                  : null,
              googleServerClientId: DefaultFirebaseOptions.googleServerClientId,
            )
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
  if (!getIt.isRegistered<LoginCubit>()) {
    getIt.registerFactory(
      () => LoginCubit(
        getIt<SignInUseCase>(),
        getIt<SignInWithGoogleUseCase>(),
        getIt<SendPasswordResetUseCase>(),
      ),
    );
  }
}
