import '../../../domain/auth/entities/auth_user.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../../../infra/adapters/auth/auth_remote_adapter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._adapter);

  final AuthRemoteAdapter _adapter;

  @override
  AuthUser? get currentUser => _adapter.currentUser?.toEntity();

  @override
  Stream<AuthUser?> authStateChanges() =>
      _adapter.authStateChanges().map((u) => u?.toEntity());

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async =>
      (await _adapter.signIn(email: email, password: password)).toEntity();

  @override
  Future<AuthUser> signUp({
    required String name,
    required String email,
    required String password,
  }) async => (await _adapter.signUp(
    name: name,
    email: email,
    password: password,
  )).toEntity();

  @override
  Future<AuthUser> signInWithGoogle() async =>
      (await _adapter.signInWithGoogle()).toEntity();

  @override
  Future<void> sendPasswordReset({required String email}) =>
      _adapter.sendPasswordReset(email: email);

  @override
  Future<void> signOut() => _adapter.signOut();
}
