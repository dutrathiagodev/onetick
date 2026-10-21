import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/widgets/state_views.dart';

/// New user: nothing recorded yet.
class HistoryEmptyView extends StatelessWidget {
  const HistoryEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      iconAsset: AppAssets.leaf,
      title: 'Seu histórico começa hoje',
      message:
          'Conclua o foco do dia e acompanhe sua constância silenciosa aqui.',
    );
  }
}
