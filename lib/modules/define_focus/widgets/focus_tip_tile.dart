import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';

class FocusTipTile extends StatelessWidget {
  const FocusTipTile({super.key});

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
              color: colors.surfaceStronger,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: AppIcon(AppAssets.bulb, tint: colors.text),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Ao escolher uma única tarefa essencial, você reduz a ansiedade e garante progresso genuíno.',
              style: AppTextStyles.label.copyWith(color: colors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
