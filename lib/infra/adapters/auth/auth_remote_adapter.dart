import '../../../data/auth/models/auth_user_model.dart';

abstract interface class AuthRemoteAdapter {
  AuthUserModel? get currentUser;

  Stream<AuthUserModel?> authStateChanges();

  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  });

  Future<AuthUserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthUserModel> signInWithGoogle();

  Future<void> sendPasswordReset({required String email});

  Future<void> signOut();
}
