import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';

/// "Ritmo Sereno" progress summary: 0% while pending, 100% once completed.
class RhythmCard extends StatelessWidget {
  const RhythmCard({super.key, required this.completed});

  final bool completed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceMuted,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.background,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: AppIcon(AppAssets.ritmo, tint: colors.textMuted),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ritmo Sereno',
                  style: AppTextStyles.labelSemi.copyWith(color: colors.text),
                ),
                Text(
                  'Conclua seu dia com calma.',
                  style: AppTextStyles.label.copyWith(color: colors.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                completed ? '100%' : '0%',
                key: const Key('today_rhythm_percent'),
                style: AppTextStyles.subtitle.copyWith(
                  color: colors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2.5),
              Text(
                completed ? '1 de 1 foco' : '0 de 1 foco',
                style: AppTextStyles.caption.copyWith(color: colors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
