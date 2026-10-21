import '../../../core/failures.dart';

/// Pure validation rules shared by the sign in / sign up use cases.
abstract final class AuthValidators {
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static const int minPasswordLength = 8;

  static String email(String raw) {
    final value = raw.trim();
    if (value.isEmpty) throw const AppFailure('Informe seu e-mail.');
    if (!_email.hasMatch(value)) {
      throw const AppFailure('Digite um e-mail válido.');
    }
    return value;
  }

  static String loginPassword(String value) {
    if (value.isEmpty) throw const AppFailure('Informe sua senha.');
    return value;
  }

  static String newPassword(String value) {
    if (value.length < minPasswordLength) {
      throw const AppFailure('A senha precisa ter no mínimo 8 caracteres.');
    }
    return value;
  }

  static String name(String raw) {
    final value = raw.trim();
    if (value.isEmpty) throw const AppFailure('Informe como quer ser chamado.');
    return value;
  }
}
