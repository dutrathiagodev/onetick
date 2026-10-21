import '../../../domain/auth/entities/auth_user.dart';

class AuthUserModel {
  const AuthUserModel({required this.id, required this.email, this.name});

  final String id;
  final String email;
  final String? name;

  AuthUser toEntity() => AuthUser(id: id, email: email, name: name);
}
