import '../repositories/auth_repository.dart';
import 'auth_validators.dart';

class SendPasswordResetUseCase {
  const SendPasswordResetUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call(String email) =>
      _repository.sendPasswordReset(email: AuthValidators.email(email));
}
