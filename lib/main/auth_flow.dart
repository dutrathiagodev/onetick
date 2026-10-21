import 'package:flutter/material.dart';

import '../core/routes/app_routes.dart';
import '../modules/login/page/login_page.dart';
import '../modules/onboarding/page/onboarding_page.dart';
import '../modules/register/page/register_page.dart';

/// Unauthenticated navigation: onboarding -> register / login.
class AuthFlow extends StatelessWidget {
  const AuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: AppRoutes.onboarding,
      onGenerateRoute: (settings) {
        final builder = switch (settings.name) {
          AppRoutes.login => (BuildContext c) => LoginPage(
            onGoToRegister: () =>
                Navigator.of(c).pushReplacementNamed(AppRoutes.register),
          ),
          AppRoutes.register => (BuildContext c) => RegisterPage(
            onGoToLogin: () =>
                Navigator.of(c).pushReplacementNamed(AppRoutes.login),
          ),
          _ => (BuildContext c) => OnboardingPage(
            onSkip: () => Navigator.of(c).pushNamed(AppRoutes.register),
            onFinish: () => Navigator.of(c).pushNamed(AppRoutes.register),
            onLogin: () => Navigator.of(c).pushNamed(AppRoutes.login),
          ),
        };
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
