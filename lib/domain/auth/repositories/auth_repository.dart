import '../entities/auth_user.dart';

abstract interface class AuthRepository {
  AuthUser? get currentUser;

  Stream<AuthUser?> authStateChanges();

  Future<AuthUser> signIn({required String email, required String password});

  Future<AuthUser> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthUser> signInWithGoogle();

  Future<void> sendPasswordReset({required String email});

  Future<void> signOut();

  /// Throws when the provider would refuse to delete the account (sign-in too
  /// old), so nothing is erased before the account itself can go.
  Future<void> ensureCanDeleteAccount();

  /// Permanently deletes the signed in account.
  Future<void> deleteAccount();
}
