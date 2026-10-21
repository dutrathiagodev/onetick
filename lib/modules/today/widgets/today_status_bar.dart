import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/dot_pill.dart';

/// "HOJE • 24 OUT" date pill on the left, streak pill on the right.
class TodayStatusBar extends StatelessWidget {
  const TodayStatusBar({super.key, required this.today, required this.streak});

  final DateTime today;
  final int streak;

  static String streakLabel(int streak) =>
      streak == 1 ? '1 dia seguido' : '$streak dias seguidos';

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: DotPill(
              label: DateUtilsX.todayBadge(today).toUpperCase(),
              background: colors.surfaceMuted,
              dotSize: 8,
              gap: 4,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              textStyle: AppTextStyles.caption.copyWith(
                color: colors.textMuted,
                letterSpacing: 0.55,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              key: const Key('today_streak_pill'),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: ShapeDecoration(
                color: colors.surfaceMuted,
                shape: const StadiumBorder(),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(AppAssets.flameDark, tint: colors.brand),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      streakLabel(streak),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: colors.text,
                        letterSpacing: 0.275,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
