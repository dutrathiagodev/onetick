import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failures.dart';
import '../../domain/auth/usecases/sign_in_with_google_use_case.dart';
import '../../domain/auth/usecases/sign_up_use_case.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._signUp, this._signInWithGoogle)
    : super(const RegisterState());

  final SignUpUseCase _signUp;
  final SignInWithGoogleUseCase _signInWithGoogle;

  Future<void> submit({
    required String name,
    required String email,
    required String password,
  }) {
    return _run(() => _signUp(name: name, email: email, password: password));
  }

  Future<void> continueWithGoogle() => _run(() => _signInWithGoogle());

  void clearError() {
    if (state.status == RegisterStatus.failure) emit(const RegisterState());
  }

  Future<void> _run(Future<Object?> Function() action) async {
    if (state.isSubmitting) return;
    emit(const RegisterState(status: RegisterStatus.submitting));
    try {
      await action();
      if (!isClosed) emit(const RegisterState());
    } on AppFailure catch (e) {
      if (!isClosed) {
        emit(RegisterState(status: RegisterStatus.failure, message: e.message));
      }
    } catch (_) {
      if (!isClosed) {
        emit(
          const RegisterState(
            status: RegisterStatus.failure,
            message: 'Algo deu errado. Tente novamente.',
          ),
        );
      }
    }
  }
}
