import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';
import '../../today/widgets/today_status_bar.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key, required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Histórico de Foco',
                style: AppTextStyles.title.copyWith(color: colors.text),
              ),
              Text(
                'Constância silenciosa, dia após dia',
                style: AppTextStyles.label.copyWith(color: colors.textMuted),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          key: const Key('history_streak_pill'),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: ShapeDecoration(
            color: colors.mint,
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
              AppIcon(AppAssets.flameGreen, tint: colors.onMint),
              const SizedBox(width: 6),
              Text(
                TodayStatusBar.streakLabel(streak),
                style: AppTextStyles.caption.copyWith(
                  color: colors.onMint,
                  letterSpacing: 0.275,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
