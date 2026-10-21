import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../domain/history/entities/history_day.dart';

/// Last 7 days, one row per day: done / pending / rest.
class RecentDaysList extends StatelessWidget {
  const RecentDaysList({super.key, required this.days, required this.today});

  final List<HistoryDay> days;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < days.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _RecentDayTile(day: days[i], today: today),
        ],
      ],
    );
  }
}

class _RecentDayTile extends StatelessWidget {
  const _RecentDayTile({required this.day, required this.today});

  final HistoryDay day;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final entry = day.entry;
    final done = entry?.completed ?? false;
    final rest = entry == null;
    final title = rest ? 'Sem foco registrado' : entry.title;
    final badge = done ? 'Feito' : (rest ? 'Descanso' : 'Pendente');

    final tile = AppCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: done ? colors.brand : colors.surfaceStrong,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: done
                ? AppIcon(AppAssets.checkWhite14, tint: colors.onBrand)
                : AppIcon(AppAssets.dash, tint: colors.textMuted),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: rest ? colors.textMuted : colors.text,
                  ),
                ),
                Text(
                  DateUtilsX.relativeDayLabel(day.date, today),
                  style: AppTextStyles.caption.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: ShapeDecoration(
              color: done
                  ? colors.mint.withValues(alpha: 0.5)
                  : colors.surfaceStrong,
              shape: const StadiumBorder(),
            ),
            child: Text(
              badge,
              style: AppTextStyles.caption.copyWith(
                color: done ? colors.brand : colors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
    return rest ? Opacity(opacity: 0.7, child: tile) : tile;
  }
}
