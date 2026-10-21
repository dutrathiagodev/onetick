import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import 'complete_button.dart';

/// White card with the single daily focus and the "tap to complete" button.
class FocusCard extends StatelessWidget {
  const FocusCard({
    super.key,
    required this.title,
    required this.isCompleting,
    required this.onComplete,
    required this.onChangeFocus,
  });

  final String title;
  final bool isCompleting;
  final VoidCallback onComplete;
  final VoidCallback onChangeFocus;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: ShapeDecoration(
                  color: colors.surfaceContainer,
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  'META SOLITÁRIA',
                  style: AppTextStyles.caption.copyWith(
                    color: colors.textMuted,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              AppIcon(AppAssets.seed, tint: colors.textMuted),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colors.mint.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: AppIcon(AppAssets.drop, tint: colors.brandStrong),
          ),
          const SizedBox(height: 16),
          Text(
            'FOCO ÚNICO',
            style: AppTextStyles.labelSemi.copyWith(
              color: colors.brand,
              letterSpacing: 0.65,
            ),
          ),
          const SizedBox(height: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Text(
              title,
              key: const Key('today_focus_title'),
              textAlign: TextAlign.center,
              style: AppTextStyles.headline.copyWith(
                color: colors.text,
                height: 35 / 28,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 240),
            child: Text(
              'Uma respiração, um hábito calmo por vez. Sem distrações.',
              textAlign: TextAlign.center,
              style: AppTextStyles.label.copyWith(color: colors.textMuted),
            ),
          ),
          const SizedBox(height: 40),
          CompleteButton(isLoading: isCompleting, onPressed: onComplete),
          const SizedBox(height: 40),
          Center(
            child: Material(
              color: colors.surfaceContainer,
              shape: const StadiumBorder(),
              child: InkWell(
                key: const Key('today_change_focus'),
                customBorder: const StadiumBorder(),
                onTap: isCompleting ? null : onChangeFocus,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(AppAssets.swap, tint: colors.textMuted),
                      const SizedBox(width: 6),
                      Text(
                        'Trocar Foco',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
