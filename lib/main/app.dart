import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/app_theme.dart';
import '../presenter/session/session_cubit.dart';
import '../presenter/session/session_state.dart';
import '../presenter/settings/app_theme_cubit.dart';
import 'di/service_locator.dart';
import 'session_gate.dart';

class OneTickApp extends StatelessWidget {
  const OneTickApp({super.key, this.showLocalModeStrip = true});

  /// Debug-only strip shown when running without Firebase.
  final bool showLocalModeStrip;

  @override
  Widget build(BuildContext context) {
    final useFirebase = getIt<AppConfig>().useFirebase;
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionCubit>.value(value: getIt<SessionCubit>()),
        BlocProvider<AppThemeCubit>.value(value: getIt<AppThemeCubit>()),
      ],
      child: BlocListener<SessionCubit, SessionState>(
        listener: (context, state) {
          final theme = context.read<AppThemeCubit>();
          if (state is SessionAuthenticated) {
            theme.restore();
          } else if (state is SessionUnauthenticated) {
            theme.reset();
          }
        },
        child: BlocBuilder<AppThemeCubit, ThemeMode>(
          builder: (context, mode) => MaterialApp(
            title: 'OneTick',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            builder: (context, child) =>
                (useFirebase || !kDebugMode || !showLocalModeStrip)
                ? child!
                : Column(
                    children: [
                      Expanded(child: child!),
                      const _LocalModeStrip(),
                    ],
                  ),
            home: const SessionGate(),
          ),
        ),
      ),
    );
  }
}

/// Debug-only reminder that data lives in memory (Firebase not configured).
class _LocalModeStrip extends StatelessWidget {
  const _LocalModeStrip();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFBA1A1A),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(
            'MODO LOCAL · Firebase não configurado · dados em memória',
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
