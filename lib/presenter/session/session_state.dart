import 'package:equatable/equatable.dart';

import '../../domain/auth/entities/auth_user.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

class SessionUnknown extends SessionState {
  const SessionUnknown();
}

class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated();
}

class SessionAuthenticated extends SessionState {
  const SessionAuthenticated(this.user);

  final AuthUser user;

  @override
  List<Object?> get props => [user];
}
