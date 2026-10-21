import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/auth/usecases/sign_out_use_case.dart';
import '../../domain/auth/usecases/watch_auth_state_use_case.dart';
import 'session_state.dart';

/// App-wide authentication session (drives the auth gate).
class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._watchAuthState, this._signOut)
    : super(const SessionUnknown()) {
    _subscription = _watchAuthState().listen(
      (user) => emit(
        user == null
            ? const SessionUnauthenticated()
            : SessionAuthenticated(user),
      ),
      onError: (_) => emit(const SessionUnauthenticated()),
    );
  }

  final WatchAuthStateUseCase _watchAuthState;
  final SignOutUseCase _signOut;
  StreamSubscription<dynamic>? _subscription;

  Future<void> signOut() => _signOut();

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
