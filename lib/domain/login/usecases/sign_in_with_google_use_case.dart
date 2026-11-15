import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  const SignInWithGoogleUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call() => _repository.signInWithGoogle();
}
