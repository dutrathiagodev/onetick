import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/widgets/state_views.dart';
import '../modules/shell/page/shell_page.dart';
import '../presenter/session/session_cubit.dart';
import '../presenter/session/session_state.dart';
import 'auth_flow.dart';

/// Chooses between the auth flow and the signed-in shell.
class SessionGate extends StatelessWidget {
  const SessionGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) => switch (state) {
        SessionUnknown() => const Scaffold(body: LoadingStateView()),
        SessionUnauthenticated() => const AuthFlow(key: ValueKey('auth_flow')),
        SessionAuthenticated(:final user) => ShellPage(
          key: ValueKey('shell_${user.id}'),
        ),
      },
    );
  }
}
