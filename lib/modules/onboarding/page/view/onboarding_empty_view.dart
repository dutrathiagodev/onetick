import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/widgets/state_views.dart';

class OnboardingEmptyView extends StatelessWidget {
  const OnboardingEmptyView({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      iconAsset: AppAssets.plant,
      title: 'Bem-vindo ao OneTick',
      message: 'Um compromisso essencial por dia. Sem distrações.',
      actionLabel: 'Começar',
      onAction: onContinue,
    );
  }
}
