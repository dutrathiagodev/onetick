import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../domain/history/entities/history_overview.dart';

/// Month calendar with completed days highlighted and month navigation.
class HistoryCalendarCard extends StatelessWidget {
  const HistoryCalendarCard({
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

  static const _weekdayLetters = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final month = overview.month;
    final total = DateUtilsX.daysInMonth(month.year, month.month);
    // DateTime.weekday: Monday=1..Sunday=7; calendar starts on Sunday.
    final leading = DateTime(month.year, month.month).weekday % 7;
    final cellCount = leading + total;
    final rows = (cellCount / 7).ceil();
    final isCurrentMonth =
        month.year == today.year && month.month == today.month;

    return AppCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  DateUtilsX.monthTitle(month),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  key: const Key('history_month_title'),
                  style: AppTextStyles.subtitle.copyWith(color: colors.text),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  _MonthButton(
                    key: const Key('history_prev_month'),
                    label: 'Mês anterior',
                    asset: AppAssets.chevronLeft,
                    onPressed: isRefreshing ? null : onPreviousMonth,
                  ),
                  const SizedBox(width: 4),
                  _MonthButton(
                    key: const Key('history_next_month'),
                    label: 'Próximo mês',
                    asset: AppAssets.chevronRightSmall,
                    onPressed: (!canGoNext || isRefreshing)
                        ? null
                        : onNextMonth,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (final letter in _weekdayLetters)
                Expanded(
                  child: Center(
                    child: Text(
                      letter,
                      style: AppTextStyles.caption.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          for (var r = 0; r < rows; r++)
            Padding(
              padding: EdgeInsets.only(top: r == 0 ? 0 : 8),
              child: Row(
                children: [
                  for (var c = 0; c < 7; c++)
                    Expanded(
                      child: Center(
                        child: _dayCell(
                          r * 7 + c - leading + 1,
                          total,
                          isCurrentMonth,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 6,
              children: [
                _LegendDot(color: colors.brand, label: 'Concluído'),
                _LegendDot(color: colors.surfaceStrong, label: 'Não marcado'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayCell(int day, int total, bool isCurrentMonth) {
    if (day < 1 || day > total) return const SizedBox(width: 32, height: 32);
    return _DayCell(
      day: day,
      completed: overview.completedDays.contains(day),
      isToday: isCurrentMonth && day == today.day,
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.completed,
    required this.isToday,
  });

  final int day;
  final bool completed;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      label:
          'Dia $day${completed ? ', concluído' : ''}${isToday ? ', hoje' : ''}',
      child: Container(
        key: Key('history_day_$day'),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: completed ? colors.brand : colors.surfaceStrong,
          shape: BoxShape.circle,
          boxShadow: [
            if (completed)
              const BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            if (isToday) ...[
              BoxShadow(color: colors.surface, spreadRadius: 2),
              BoxShadow(color: colors.inverse, spreadRadius: 4),
            ],
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '$day',
          style: AppTextStyles.labelMedium.copyWith(
            color: completed ? colors.onBrand : colors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _MonthButton extends StatelessWidget {
  const _MonthButton({
    super.key,
    required this.label,
    required this.asset,
    required this.onPressed,
  });

  final String label;
  final String asset;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: Opacity(
        opacity: onPressed == null ? 0.4 : 1,
        child: Material(
          color: colors.surfaceMuted,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: SizedBox(
              width: 32,
              height: 32,
              child: Center(child: AppIcon(asset, tint: colors.textMuted)),
            ),
          ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: context.colors.textMuted,
          ),
        ),
      ],
    );
  }
}
