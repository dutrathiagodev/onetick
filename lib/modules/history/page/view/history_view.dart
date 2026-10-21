import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../domain/history/entities/history_overview.dart';
import '../../widgets/history_calendar_card.dart';
import '../../widgets/history_header.dart';
import '../../widgets/history_note_tile.dart';
import '../../widgets/history_stats_row.dart';
import '../../widgets/recent_days_list.dart';

/// Success scenario: stats, month calendar and last 7 days.
class HistoryView extends StatelessWidget {
  const HistoryView({
    super.key,
    required this.overview,
    required this.today,
    required this.canGoNext,
    required this.isRefreshing,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  final HistoryOverview overview;
  final DateTime today;
  final bool canGoNext;
  final bool isRefreshing;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HistoryHeader(streak: overview.streak),
          const SizedBox(height: 24),
          HistoryStatsRow(overview: overview, today: today),
          const SizedBox(height: 24),
          HistoryCalendarCard(
            overview: overview,
            today: today,
            canGoNext: canGoNext,
            isRefreshing: isRefreshing,
            onPreviousMonth: onPreviousMonth,
            onNextMonth: onNextMonth,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Últimos 7 Dias',
                  style: AppTextStyles.subtitle.copyWith(color: colors.text),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Foco diário realizado',
                    textAlign: TextAlign.end,
                    style: AppTextStyles.caption.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RecentDaysList(days: overview.recentDays, today: today),
          const SizedBox(height: 24),
          const HistoryNoteTile(),
        ],
      ),
    );
  }
}
