import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../domain/history/entities/history_overview.dart';

/// "Conclusões" and "Taxa de Sucesso" cards.
class HistoryStatsRow extends StatelessWidget {
  const HistoryStatsRow({
    super.key,
    required this.overview,
    required this.today,
  });

  final HistoryOverview overview;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isCurrentMonth =
        overview.month.year == today.year &&
        overview.month.month == today.month;
    final monthLabel = isCurrentMonth
        ? 'Neste mês'
        : 'Em ${DateUtilsX.monthName(overview.month.month).toLowerCase()}';
    final count = overview.completedCount;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _StatCard(
              title: 'Conclusões',
              icon: AppIcon(AppAssets.checkCircle, tint: colors.brand),
              value: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$count',
                    key: const Key('history_completed_count'),
                    style: AppTextStyles.headline.copyWith(color: colors.text),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    count == 1 ? 'dia' : 'dias',
                    style: AppTextStyles.label.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
              caption: Text(
                monthLabel,
                style: AppTextStyles.captionMedium.copyWith(
                  color: colors.brand,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _StatCard(
              title: 'Taxa de Sucesso',
              icon: AppIcon(AppAssets.successRing, tint: colors.brand),
              value: Text(
                '${overview.successRate}%',
                key: const Key('history_success_rate'),
                style: AppTextStyles.headline.copyWith(color: colors.text),
              ),
              caption: Text(
                '$count de ${overview.activeDays} dias ativos',
                style: AppTextStyles.caption.copyWith(color: colors.textMuted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.caption,
  });

  final String title;
  final Widget icon;
  final Widget value;
  final Widget caption;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              icon,
            ],
          ),
          Padding(padding: const EdgeInsets.only(top: 8), child: value),
          Padding(padding: const EdgeInsets.only(top: 4), child: caption),
        ],
      ),
    );
  }
}
