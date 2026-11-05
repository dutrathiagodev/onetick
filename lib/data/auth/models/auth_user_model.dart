import '../../../domain/auth/entities/auth_user.dart';

class AuthUserModel {
  const AuthUserModel({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
  });

  final String id;
  final String email;
  final String? name;
  final String? photoUrl;

  AuthUser toEntity() =>
      AuthUser(id: id, email: email, name: name, photoUrl: photoUrl);
}
