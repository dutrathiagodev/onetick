import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/failures.dart';
import '../../../data/auth/models/auth_user_model.dart';
import 'auth_remote_adapter.dart';

class FirebaseAuthAdapter implements AuthRemoteAdapter {
  FirebaseAuthAdapter({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
    : _auth = auth ?? FirebaseAuth.instance,
      _google = googleSignIn ?? GoogleSignIn.instance;

  final FirebaseAuth _auth;
  final GoogleSignIn _google;
  Future<void>? _googleInit;

  @override
  AuthUserModel? get currentUser => _map(_auth.currentUser);

  @override
  Stream<AuthUserModel?> authStateChanges() =>
      _auth.authStateChanges().map(_map);

  @override
  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _require(cred.user);
    });
  }

  @override
  Future<AuthUserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = _require(cred.user);
      await cred.user!.updateDisplayName(name);
      return AuthUserModel(id: user.id, email: user.email, name: name);
    });
  }

  @override
  Future<AuthUserModel> signInWithGoogle() {
    return _guard(() async {
      await (_googleInit ??= _google.initialize());
      final account = await _google.authenticate();
      final idToken = account.authentication.idToken;
      final cred = await _auth.signInWithCredential(
        GoogleAuthProvider.credential(idToken: idToken),
      );
      return _require(cred.user);
    });
  }

  @override
  Future<void> sendPasswordReset({required String email}) {
    return _guard(() => _auth.sendPasswordResetEmail(email: email));
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    try {
      await _google.signOut();
    } catch (_) {
      // Google session may not exist; Firebase sign out is what matters.
    }
  }

  AuthUserModel? _map(User? user) {
    if (user == null) return null;
    return AuthUserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName,
    );
  }

  AuthUserModel _require(User? user) {
    final mapped = _map(user);
    if (mapped == null) {
      throw const AppFailure(
        'Não foi possível concluir o acesso. Tente novamente.',
      );
    }
    return mapped;
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AppFailure {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw AppFailure(_message(e.code));
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const AppFailure('Login com Google cancelado.');
      }
      throw const AppFailure('Não foi possível entrar com o Google.');
    } catch (_) {
      throw const AppFailure(
        'Algo deu errado. Verifique sua conexão e tente novamente.',
      );
    }
  }

  static String _message(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Digite um e-mail válido.';
      case 'user-disabled':
        return 'Esta conta foi desativada.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-mail ou senha incorretos.';
      case 'email-already-in-use':
        return 'Este e-mail já está em uso. Tente entrar.';
      case 'weak-password':
        return 'Escolha uma senha mais forte (mínimo 8 caracteres).';
      case 'network-request-failed':
        return 'Sem conexão. Verifique sua internet.';
      case 'too-many-requests':
        return 'Muitas tentativas. Aguarde um instante e tente de novo.';
      default:
        return 'Não foi possível concluir o acesso. Tente novamente.';
    }
  }
}
