import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class WatchAuthStateUseCase {
  const WatchAuthStateUseCase(this._repository);

  final AuthRepository _repository;

  AuthUser? get current => _repository.currentUser;

  Stream<AuthUser?> call() => _repository.authStateChanges();
}
