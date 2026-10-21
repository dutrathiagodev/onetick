import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import 'auth_validators.dart';

class SignUpUseCase {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.signUp(
      name: AuthValidators.name(name),
      email: AuthValidators.email(email),
      password: AuthValidators.newPassword(password),
    );
  }
}
