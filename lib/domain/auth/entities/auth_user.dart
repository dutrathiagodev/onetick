import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
  });

  final String id;
  final String email;
  final String? name;

  /// Profile picture from the sign-in provider (Google); null for e-mail.
  final String? photoUrl;

  @override
  List<Object?> get props => [id, email, name, photoUrl];
}
