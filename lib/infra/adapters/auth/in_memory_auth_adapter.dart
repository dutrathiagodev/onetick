import 'dart:async';

import '../../../core/failures.dart';
import '../../../data/auth/models/auth_user_model.dart';
import 'auth_remote_adapter.dart';

/// Offline/dev adapter used by tests and when Firebase is not configured.
class InMemoryAuthAdapter implements AuthRemoteAdapter {
  InMemoryAuthAdapter({AuthUserModel? initialUser}) : _current = initialUser;

  final Map<String, ({String password, AuthUserModel user})> _accounts = {};
  final StreamController<AuthUserModel?> _controller =
      StreamController<AuthUserModel?>.broadcast();
  AuthUserModel? _current;

  @override
  AuthUserModel? get currentUser => _current;

  @override
  Stream<AuthUserModel?> authStateChanges() async* {
    yield _current;
    yield* _controller.stream;
  }

  @override
  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) async {
    final account = _accounts[email.toLowerCase()];
    if (account == null || account.password != password) {
      throw const AppFailure('E-mail ou senha incorretos.');
    }
    return _emit(account.user);
  }

  @override
  Future<AuthUserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final key = email.toLowerCase();
    if (_accounts.containsKey(key)) {
      throw const AppFailure('Este e-mail já está em uso. Tente entrar.');
    }
    final user = AuthUserModel(
      id: 'local-${_accounts.length + 1}',
      email: email,
      name: name,
    );
    _accounts[key] = (password: password, user: user);
    return _emit(user);
  }

  @override
  Future<AuthUserModel> signInWithGoogle() async {
    return _emit(
      const AuthUserModel(
        id: 'local-google',
        email: 'google@onetick.dev',
        name: 'Google User',
      ),
    );
  }

  @override
  Future<void> sendPasswordReset({required String email}) async {
    if (!_accounts.containsKey(email.toLowerCase())) {
      // Mirrors Firebase, which does not reveal whether the account exists.
      return;
    }
  }

  @override
  Future<void> signOut() async {
    _current = null;
    _controller.add(null);
  }

  AuthUserModel _emit(AuthUserModel user) {
    _current = user;
    _controller.add(user);
    return user;
  }
}
