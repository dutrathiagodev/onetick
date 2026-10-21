import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../domain/focus/entities/focus_entity.dart';

/// Main card of the "Foco Concluído" screen.
class CompletedFocusCard extends StatelessWidget {
  const CompletedFocusCard({super.key, required this.focus});

  final FocusEntity focus;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final at = focus.completedAt;
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: ShapeDecoration(
              color: colors.mint,
              shape: const StadiumBorder(),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(AppAssets.checkGreen13, tint: colors.onMint),
                const SizedBox(width: 6),
                Text(
                  'FOCO CONCLUÍDO',
                  style: AppTextStyles.caption.copyWith(
                    color: colors.onMint,
                    letterSpacing: 0.55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: colors.mint.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colors.brand,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: AppIcon(AppAssets.checkWhite14, tint: colors.onBrand),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Dia concluído em paz',
            key: const Key('today_completed_heading'),
            textAlign: TextAlign.center,
            style: AppTextStyles.headline.copyWith(color: colors.text),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceMuted,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon(AppAssets.checkCircle, tint: colors.brand),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        focus.title,
                        key: const Key('today_completed_title'),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: colors.text,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  at == null
                      ? 'Feito por hoje. Descanse sua mente!'
                      : 'Concluído às ${DateFormat('HH:mm').format(at)}. Descanse sua mente!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.label.copyWith(color: colors.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
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
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Você está construindo consistência silenciosa dia após dia.',
                    style: AppTextStyles.label.copyWith(
                      color: colors.textMuted,
                    ),
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
