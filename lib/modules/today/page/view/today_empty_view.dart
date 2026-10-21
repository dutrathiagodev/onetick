import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/widgets/state_views.dart';
import '../../widgets/today_status_bar.dart';

/// No focus chosen yet for today: invites the user to define it.
class TodayEmptyView extends StatelessWidget {
  const TodayEmptyView({
    super.key,
    required this.today,
    required this.streak,
    required this.onDefineFocus,
  });

  final DateTime today;
  final int streak;
  final VoidCallback onDefineFocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: TodayStatusBar(today: today, streak: streak),
        ),
        Expanded(
          child: EmptyStateView(
            iconAsset: AppAssets.plant,
            title: 'Qual é o seu foco de hoje?',
            message: 'Escolha apenas 1 compromisso essencial para o dia.',
            actionLabel: 'Definir foco',
            onAction: onDefineFocus,
          ),
        ),
      ],
    );
  }
}
