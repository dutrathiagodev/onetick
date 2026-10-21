import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failures.dart';
import '../../domain/auth/usecases/send_password_reset_use_case.dart';
import '../../domain/auth/usecases/sign_in_use_case.dart';
import '../../domain/auth/usecases/sign_in_with_google_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._signIn, this._signInWithGoogle, this._sendPasswordReset)
    : super(const LoginState());

  final SignInUseCase _signIn;
  final SignInWithGoogleUseCase _signInWithGoogle;
  final SendPasswordResetUseCase _sendPasswordReset;

  Future<void> submit({required String email, required String password}) {
    return _run(() => _signIn(email: email, password: password));
  }

  Future<void> continueWithGoogle() => _run(() => _signInWithGoogle());

  Future<void> forgotPassword(String email) async {
    await _run(
      () async {
        await _sendPasswordReset(email);
        return null;
      },
      successState: const LoginState(
        status: LoginStatus.resetSent,
        message: 'Enviamos um link de recuperação para o seu e-mail.',
      ),
    );
  }

  void clearError() {
    if (state.status == LoginStatus.failure ||
        state.status == LoginStatus.resetSent) {
      emit(const LoginState());
    }
  }

  /// On sign in success the session stream flips the auth gate, so we go idle.
  Future<void> _run(
    Future<Object?> Function() action, {
    LoginState successState = const LoginState(),
  }) async {
    if (state.isSubmitting) return;
    emit(const LoginState(status: LoginStatus.submitting));
    try {
      await action();
      if (!isClosed) emit(successState);
    } on AppFailure catch (e) {
      if (!isClosed) {
        emit(LoginState(status: LoginStatus.failure, message: e.message));
      }
    } catch (_) {
      if (!isClosed) {
        emit(
          const LoginState(
            status: LoginStatus.failure,
            message: 'Algo deu errado. Tente novamente.',
          ),
        );
      }
    }
  }
}
