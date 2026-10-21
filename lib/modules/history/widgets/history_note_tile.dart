import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';

class HistoryNoteTile extends StatelessWidget {
  const HistoryNoteTile({super.key});

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
              color: colors.mint,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: AppIcon(AppAssets.leaf, tint: colors.brandStrong),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Um passo por vez',
                  style: AppTextStyles.labelMedium.copyWith(color: colors.text),
                ),
                const SizedBox(height: 1),
                Text(
                  'A consistência reduz o estresse. O progresso acumulado cria grandes transformações silenciosas.',
                  style: AppTextStyles.caption.copyWith(
                    color: colors.textMuted,
                    height: 13.75 / 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
