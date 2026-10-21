import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';

/// Slide 2 illustration: today's single goal and the week dots.
class OnboardingArtOnePriority extends StatelessWidget {
  const OnboardingArtOnePriority({super.key});

  static const _days = [
    ('SEG', _DayState.done),
    ('TER', _DayState.done),
    ('QUA', _DayState.today),
    ('QUI', _DayState.upcoming),
    ('SEX', _DayState.upcoming),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surfaceMuted,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HOJE • 08:30',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textMuted,
                  letterSpacing: 0.55,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: ShapeDecoration(
                  color: colors.surface,
                  shape: const StadiumBorder(),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(AppAssets.checkCircleMini, tint: colors.brand),
                    const SizedBox(width: 4),
                    Text(
                      '1/1 meta',
                      style: AppTextStyles.caption.copyWith(color: colors.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: colors.brand,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: AppIcon(AppAssets.checkWhite12, tint: colors.onBrand),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Revisar proposta do produto',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: colors.text,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colors.brand,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              'Foco concluído para hoje',
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.caption.copyWith(
                                color: colors.brand,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              for (var i = 0; i < _days.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: _DayTile(label: _days[i].$1, state: _days[i].$2),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

enum _DayState { done, today, upcoming }

class _DayTile extends StatelessWidget {
  const _DayTile({required this.label, required this.state});

  final String label;
  final _DayState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isToday = state == _DayState.today;
    final isUpcoming = state == _DayState.upcoming;
    final tile = Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, isToday ? 8 : 10),
      decoration: BoxDecoration(
        color: isToday
            ? colors.surface
            : colors.surface.withValues(alpha: isUpcoming ? 0.4 : 0.6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isToday
            ? const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isToday ? colors.text : colors.textMuted,
            ),
          ),
          const SizedBox(height: 6),
          if (isToday)
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: colors.brand,
                shape: BoxShape.circle,
                border: Border.all(color: colors.mint, width: 2),
                boxShadow: [BoxShadow(color: colors.mint, spreadRadius: 2)],
              ),
            )
          else
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isUpcoming ? colors.outline : colors.brand,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
    return isUpcoming ? Opacity(opacity: 0.5, child: tile) : tile;
  }
}
