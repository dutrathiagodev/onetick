import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/di/screens/onboarding_dependencies.dart';
import '../../../main/di/service_locator.dart';
import '../../../presenter/onboarding/onboarding_cubit.dart';
import '../../../presenter/onboarding/onboarding_state.dart';
import 'view/onboarding_empty_view.dart';
import 'view/onboarding_error_view.dart';
import 'view/onboarding_loading_view.dart';
import 'view/onboarding_view.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.onSkip,
    required this.onFinish,
    required this.onLogin,
  });

  /// "Pular": leaves the intro without reading every slide.
  final VoidCallback onSkip;

  /// "Começar agora" on the last slide.
  final VoidCallback onFinish;

  /// "Já tem uma conta? Entrar".
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    setupOnboardingDependencies();
    return BlocProvider<OnboardingCubit>(
      create: (_) => getIt<OnboardingCubit>()..load(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) => switch (state) {
            OnboardingLoading() => const OnboardingLoadingView(),
            OnboardingError(:final message) => OnboardingErrorView(
              message: message,
              onRetry: () => context.read<OnboardingCubit>().load(),
            ),
            OnboardingEmpty() => OnboardingEmptyView(onContinue: onSkip),
            OnboardingSuccess() => OnboardingView(
              state: state,
              onPageChanged: context.read<OnboardingCubit>().pageChanged,
              onSkip: onSkip,
              onFinish: onFinish,
              onLogin: onLogin,
            ),
          },
        ),
      ),
    );
  }
}
