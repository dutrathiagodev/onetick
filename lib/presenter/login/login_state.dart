import 'package:equatable/equatable.dart';

enum LoginStatus { idle, submitting, failure, resetSent }

class LoginState extends Equatable {
  const LoginState({this.status = LoginStatus.idle, this.message});

  final LoginStatus status;
  final String? message;

  bool get isSubmitting => status == LoginStatus.submitting;

  @override
  List<Object?> get props => [status, message];
}
