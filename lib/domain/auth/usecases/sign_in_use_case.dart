import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import 'auth_validators.dart';

class SignInUseCase {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call({required String email, required String password}) {
    return _repository.signIn(
      email: AuthValidators.email(email),
      password: AuthValidators.loginPassword(password),
    );
  }
}
