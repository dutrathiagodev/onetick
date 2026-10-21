import 'package:equatable/equatable.dart';

enum RegisterStatus { idle, submitting, failure }

class RegisterState extends Equatable {
  const RegisterState({this.status = RegisterStatus.idle, this.message});

  final RegisterStatus status;
  final String? message;

  bool get isSubmitting => status == RegisterStatus.submitting;

  @override
  List<Object?> get props => [status, message];
}
